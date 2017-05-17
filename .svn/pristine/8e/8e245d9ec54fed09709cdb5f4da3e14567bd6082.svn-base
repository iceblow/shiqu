/**
 * 
 */
package com.daoshun.shiqu.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.exception.CustomException;
import com.daoshun.shiqu.common.Constants;
import com.daoshun.shiqu.pojo.Menu;
import com.daoshun.shiqu.pojo.OrderDetail;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * @author qiuch
 *
 */
public class OrderDetailService extends BaseService {

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = CustomException.class)
	protected void addOrderDetail(long order_id, String menu_info, float total_price) throws CustomException {
		float price = 0.0f;
		// List<OrderDetail> orderDetails = new ObjectMapper().readValue(menu_info, new TypeReference<List<OrderDetail>>() {
		// });
		List<OrderDetail> orderDetails = new Gson().fromJson(menu_info, new TypeToken<List<OrderDetail>>() {
		}.getType());
		for (OrderDetail orderDetail : orderDetails) {
			orderDetail.setOrder_id(order_id);
			orderDetail.getInfoFromMenu(dataDao.getObjectById(Menu.class, orderDetail.getMenu_id()));
			dataDao.addObject(orderDetail);
			if (orderDetail.getIs_weigh() == 1) {
				price = price + orderDetail.getPrice() * orderDetail.getQuantity() * orderDetail.getWeight();
			} else {
				price = price + orderDetail.getPrice() * orderDetail.getQuantity();
			}
		}
		BigDecimal bigDecimal = new BigDecimal(price);
		price = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		if (price != total_price) {
			throw new CustomException(Constants.PRICE_ERR_EXCEPTION);
		}
	}

	/**
	 * 计算可打折的钱
	 * 
	 * @param details
	 *            订单菜品列表
	 * @return 可打折的总额
	 */
	protected float calDiscountMoney(List<OrderDetail> details) {
		float price = 0.0f;
		for (OrderDetail orderDetail : details) {
			if (orderDetail.getCan_discount() == 1) {
				if (orderDetail.getIs_weigh() == 1) {
					price = price + orderDetail.getPrice() * orderDetail.getQuantity() * orderDetail.getWeight();
				} else {
					price = price + orderDetail.getPrice() * orderDetail.getQuantity();
				}
			}
		}
		return price;
	}
}
