/**
 * 
 */
package com.daoshun.shiqu.service;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.dao.DataDao;
import com.daoshun.shiqu.pojo.Coupon;
import com.daoshun.shiqu.pojo.DailyStatistics;
import com.daoshun.shiqu.pojo.FileInfo;
import com.daoshun.shiqu.pojo.Menu;
import com.daoshun.shiqu.pojo.MyCoupon;
import com.daoshun.shiqu.pojo.Order;
import com.daoshun.shiqu.pojo.OrderDetail;
import com.daoshun.shiqu.pojo.PrintInfo;
import com.daoshun.shiqu.pojo.Store;
import com.daoshun.shiqu.pojo.StoreArea;
import com.daoshun.shiqu.pojo.StoreSigner;
import com.daoshun.shiqu.pojo.StoreTable;
import com.daoshun.shiqu.pojo.StoreUser;

/**
 * @author qiuch
 * 
 */
@Service("baseService")
public class BaseService {

	@Resource
	public DataDao dataDao;

	@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
	public String getFilePathById(long i) {
		if (i > 0) {
			FileInfo file = (FileInfo) dataDao.getObjectById(FileInfo.class, i);
			// 拼接文件访问路径
			if (file != null) {
				String path = CommonUtils.getFileRootUrl() + file.getFile_url() + file.getFile_name();
				return path.replace(File.separator, "/");
			}
		}
		return null;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public long uploadComplete(String fileurl, String filename, int file_type) {
		FileInfo finfo = new FileInfo();
		finfo.setFile_name(filename);
		finfo.setFile_url(fileurl);
		finfo.setFile_type(file_type);
		dataDao.addObject(finfo);
		return finfo.getId();
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public String sendOrderPrint(long order_id, int type) {
		Order order = dataDao.getObjectById(Order.class, order_id);
		if (order != null) {
			Store store = dataDao.getObjectById(Store.class, order.getStore_id());
			StoreTable table = dataDao.getObjectById(StoreTable.class, order.getTable_id());
			if (table != null) {
				StoreArea storearea = dataDao.getObjectById(StoreArea.class, table.getArea_id());
				if (storearea != null) {
					PrintInfo printinfo1 = dataDao.getObjectById(PrintInfo.class, storearea.getPrint_id1());
					PrintInfo printinfo2 = dataDao.getObjectById(PrintInfo.class, storearea.getPrint_id2());
					PrintInfo printinfo3 = dataDao.getObjectById(PrintInfo.class, storearea.getPrint_id3());
					List<PrintInfo> printlist = new ArrayList<PrintInfo>();
					if (type == 1) {
						if (printinfo1 != null && printinfo1.getScope() != null && (printinfo1.getScope() == 1 || printinfo1.getScope() == 2))
							printlist.add(printinfo1);
						if (printinfo2 != null && printinfo2.getScope() != null && (printinfo2.getScope() == 1 || printinfo2.getScope() == 2))
							printlist.add(printinfo2);
						if (printinfo3 != null && printinfo3.getScope() != null && (printinfo3.getScope() == 1 || printinfo3.getScope() == 2))
							printlist.add(printinfo3);
					} else {
						if (printinfo1 != null && printinfo1.getScope() != null && (printinfo1.getScope() == 1 || printinfo1.getScope() == 3))
							printlist.add(printinfo1);
						if (printinfo2 != null && printinfo2.getScope() != null && (printinfo2.getScope() == 1 || printinfo2.getScope() == 3))
							printlist.add(printinfo2);
						if (printinfo3 != null && printinfo3.getScope() != null && (printinfo3.getScope() == 1 || printinfo3.getScope() == 3))
							printlist.add(printinfo3);
					}
					for (PrintInfo printinfo : printlist) {
						StringBuffer content = new StringBuffer();
						// 标签说明："<BR>"为换行符,"<CB></CB>"为居中放大,"<B></B>"为放大,"<C></C>"为居中,<L></L>字体变高
						// "<QR></QR>"为二维码,"<CODE>"为条形码,后面接12个数字
						DecimalFormat fnum = new DecimalFormat("#0.00");
						if (printinfo.getType() == 1) {
							content.append("<C>" + store.getStore_name() + " "+(type==1?"预结单":"结账单")+"</C><BR>");
							content.append("<B>台号:" + table.getTable_no() + "</B> 人数:" + order.getPeople_num() + "<BR>");
							content.append("下单人:" + (CommonUtils.isEmptyString(order.getOrder_name()) ? "" : order.getOrder_name()) + "<BR>");
							content.append("下单时间:" + CommonUtils.getTimeFormat(order.getOrder_time(), null) + "<BR>");
							content.append("--------------------------------<BR>");
							content.append("名称　　　　　 单价  数量 金额<BR>");
							List<OrderDetail> deldetaillist = new ArrayList<OrderDetail>();
							int menucount = 0;
							float discount_price = 0f;
							for (OrderDetail orderdetail : order.getMenu_list()) {
								// 结账单打印全部菜品已经退菜品
								// 收银单只打印未退菜品
								if (type == 1) {
									if (CommonUtils.isEmptyString(orderdetail.getMenu_name())) {
										content.append(CommonUtils.textAppend(orderdetail.getMenu_name(), 8) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 7)
												+ CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 4));
										if (orderdetail.getIs_weigh() == 0) {
											content.append(fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									} else {
										String menu_name = orderdetail.getMenu_name();
										while (menu_name.length() > 7) {
											content.append(menu_name.substring(0, 7) + "<BR>");
											menu_name = menu_name.substring(7, menu_name.length());
										}
										content.append(CommonUtils.textAppend(menu_name, 8) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 7));
										if (orderdetail.getIs_weigh() == 0) {
											content.append(
													CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 4) + fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()), 4)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									}
									if (orderdetail.getDetail_flg() == -1) {
										deldetaillist.add(orderdetail);
									}
								} else {
									if (orderdetail.getDetail_flg() >= 0) {
										menucount += orderdetail.getQuantity();
										if (orderdetail.getCan_discount() == 1) {
											if (orderdetail.getIs_weigh() == 0) {
												discount_price += orderdetail.getPrice() * orderdetail.getQuantity() ;
											}else{
												discount_price += orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight();
											}
										}
										if (CommonUtils.isEmptyString(orderdetail.getMenu_name())) {
											content.append(CommonUtils.textAppend(orderdetail.getMenu_name(), 8) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 7)
													+ CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 4));
											if (orderdetail.getIs_weigh() == 0) {
												content.append(fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
											} else if (orderdetail.getIs_weigh() == 1) {
												content.append(fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
											}

										} else {
											String menu_name = orderdetail.getMenu_name();
											while (menu_name.length() > 7) {
												content.append(menu_name.substring(0, 7) + "<BR>");
												menu_name = menu_name.substring(7, menu_name.length());
											}
											content.append(CommonUtils.textAppend(menu_name, 8) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 7));
											if (orderdetail.getIs_weigh() == 0) {
												content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 4) + fnum.format(orderdetail.getPrice() * orderdetail.getQuantity())
														+ "<BR>");
											} else if (orderdetail.getIs_weigh() == 1) {
												content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()), 4)
														+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
											}
										}
									}
								}
							}
							// 打印结账单的退菜品
							if (type == 1) {
								for (OrderDetail orderdetail : deldetaillist) {
									if (CommonUtils.isEmptyString(orderdetail.getMenu_name())) {
										content.append(CommonUtils.textAppend(orderdetail.getMenu_name(), 8) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 7)
												+ CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 4));
										if (orderdetail.getIs_weigh() == 0) {
											content.append(fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									} else {
										String menu_name = "（退）" + orderdetail.getMenu_name();
										while (menu_name.length() > 7) {
											content.append(menu_name.substring(0, 7) + "<BR>");
											menu_name = menu_name.substring(7, menu_name.length());
										}
										content.append(CommonUtils.textAppend(menu_name, 8) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 7));
										if (orderdetail.getIs_weigh() == 0) {
											content.append(CommonUtils.numberAppend("-" + String.valueOf(orderdetail.getQuantity()), 4)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(CommonUtils.numberAppend("-" + String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()), 4)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									}
								}
							}
//							content.append("备注:" + order.getComment() + "<BR>");
							content.append("--------------------------------<BR>");
							content.append("打印时间:" + CommonUtils.getTimeFormat(new Date(), null) + "<BR>");
							if (type == 2) {
								content.append("数量:" + menucount + "<BR>");
							}
							content.append("消费总额:" + fnum.format(order.getTotal_price()) + "元<BR>");
							float discountprice = 0f;
							if(order.getDiscount()>0&&order.getDiscount()<100){
								discountprice= discount_price * ((100-order.getDiscount()) / 100f);
							}
							float amount = 0;
							if (type == 2) {
								if(discountprice>0f){
									content.append("折扣:" + fnum.format(discountprice) + "元<BR>");
								}
								if (order.getMoling() > 0) {
									content.append("抹零:" + fnum.format(order.getMoling()) + "元<BR>");
								}
								if (order.getCoupon_id() != null && order.getCoupon_id() > 0) {
									MyCoupon mycoupon = dataDao.getObjectById(MyCoupon.class, order.getCoupon_id());
									Coupon coupon = mycoupon.getCoupon();
									amount = coupon.getAmount();
									content.append("优惠券:" + fnum.format(amount) + "元<BR>");
								}
							}
							content.append("--------------------------------<BR>");

							StoreSigner storesigner = dataDao.getObjectById(StoreSigner.class, order.getSigner_id());
							switch (order.getPay_type()) {
							case 1:
								if (order.getActually_pay() != null) {
									content.append("现金支付:" + fnum.format(order.getActually_pay()) + "元<BR>");
									if (order.getActually_pay() - (order.getTotal_price() - order.getMoling() - discountprice - amount) > 0)
										content.append("找零:" + fnum.format(order.getActually_pay() - (order.getTotal_price() - order.getMoling() - discountprice - amount)) + "元<BR>");
								}
								break;
							case 2:
								content.append("支付宝支付:" + fnum.format(order.getPrice()) + "<BR>");
								break;
							case 3:
								content.append("刷卡支付:" + fnum.format(order.getPrice()) + "<BR>");
								break;
							case 4:
								content.append("充值卡" + order.getCard_no() + "支付:" + fnum.format(order.getPrice()) + "<BR>");
								break;
							case 5:
								if (storesigner != null)
									content.append("签单:" + storesigner.getName() + "<BR>");
								break;
							case 6:
								if (storesigner != null)
									content.append("免单:" + storesigner.getName() + "<BR>");
								break;
							default:
								break;
							}
							CommonUtils.sendOrderPrint(printinfo.getPrint_sn(), printinfo.getPrint_key(), content.toString(), "" + (printinfo.getPrint_num() == null ? 1 : printinfo.getPrint_num()));
						} else if (printinfo.getType() == 2) {
							int menucount = 0;
							float discount_price = 0f;
							content.append("<C>" + store.getStore_name() + " "+(type==1?"预结单":"结账单")+"</C><BR>");
							content.append("<B>台号:" + table.getTable_no() + "</B> 人数:" + order.getPeople_num() + "<BR>");
							content.append("下单人:" + (CommonUtils.isEmptyString(order.getOrder_name()) ? "" : order.getOrder_name()) + "<BR>");
							content.append("下单时间:" + CommonUtils.getTimeFormat(order.getOrder_time(), null) + "<BR>");
							content.append("------------------------------------------------<BR>");
							content.append("名称　　　　　　　　　 单价     数量      金额<BR>");
							List<OrderDetail> deldetaillist = new ArrayList<OrderDetail>();
							for (OrderDetail orderdetail : order.getMenu_list()) {
								if (type == 1) {
									if (CommonUtils.isEmptyString(orderdetail.getMenu_name())) {
										content.append(CommonUtils.textAppend(orderdetail.getMenu_name(), 12) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 9));
										if (orderdetail.getIs_weigh() == 0) {
											content.append(
													CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 9) + fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()), 9)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									} else {
										String menu_name = orderdetail.getMenu_name();
										while (menu_name.length() > 11) {
											content.append(menu_name.substring(0, 11) + "<BR>");
											menu_name = menu_name.substring(11, menu_name.length());
										}
										content.append(CommonUtils.textAppend(menu_name, 12) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 9));

										if (orderdetail.getIs_weigh() == 0) {
											content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()) + orderdetail.getUnit(), 9)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()) + orderdetail.getUnit(), 9)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									}
									if (orderdetail.getDetail_flg() == -1) {
										deldetaillist.add(orderdetail);
									}
								} else {
									if (orderdetail.getDetail_flg() >= 0) {
										menucount += orderdetail.getQuantity();
										if (orderdetail.getCan_discount() == 1) {
											if (orderdetail.getIs_weigh() == 0) {
												discount_price += orderdetail.getPrice() * orderdetail.getQuantity() ;
											}else{
												discount_price += orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight();
											}
										}
										if (CommonUtils.isEmptyString(orderdetail.getMenu_name())) {
											content.append(CommonUtils.textAppend(orderdetail.getMenu_name(), 12) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 9));
											if (orderdetail.getIs_weigh() == 0) {
												content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 9) + fnum.format(orderdetail.getPrice() * orderdetail.getQuantity())
														+ "<BR>");
											} else if (orderdetail.getIs_weigh() == 1) {
												content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()), 9)
														+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
											}
										} else {
											String menu_name = orderdetail.getMenu_name();
											while (menu_name.length() > 11) {
												content.append(menu_name.substring(0, 11) + "<BR>");
												menu_name = menu_name.substring(11, menu_name.length());
											}
											content.append(CommonUtils.textAppend(menu_name, 12) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 9));

											if (orderdetail.getIs_weigh() == 0) {
												content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()) + orderdetail.getUnit(), 9)
														+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
											} else if (orderdetail.getIs_weigh() == 1) {
												content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()) + orderdetail.getUnit(), 9)
														+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
											}
										}
									}
								}
							}
							if (type == 1) {
								for (OrderDetail orderdetail : deldetaillist) {
									if (CommonUtils.isEmptyString(orderdetail.getMenu_name())) {
										content.append(CommonUtils.textAppend(orderdetail.getMenu_name(), 12) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 9));
										if (orderdetail.getIs_weigh() == 0) {
											content.append(
													CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 9) + fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()), 9)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									} else {
										String menu_name = "（退） " + orderdetail.getMenu_name();
										while (menu_name.length() > 11) {
											content.append(menu_name.substring(0, 11) + "<BR>");
											menu_name = menu_name.substring(11, menu_name.length());
										}
										content.append(CommonUtils.textAppend(menu_name, 12) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 9));

										if (orderdetail.getIs_weigh() == 0) {
											content.append(CommonUtils.numberAppend("-" + String.valueOf(orderdetail.getQuantity()) + orderdetail.getUnit(), 9)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(CommonUtils.numberAppend("-" + String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()) + orderdetail.getUnit(), 9)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									}
								}
							}
//							content.append("备注:" + order.getComment() + "<BR>");
							content.append("------------------------------------------------<BR>");
							content.append("打印时间:" + CommonUtils.getTimeFormat(new Date(), null) + "<BR>");
							if (type == 2) {
								content.append("数量:" + menucount + "<BR>");
							}
							content.append("消费总额:" + fnum.format(order.getTotal_price()) + "元<BR>");
							float discountprice = 0f;
							if(order.getDiscount()>0&&order.getDiscount()<100){
								discountprice= discount_price * ((100-order.getDiscount()) / 100f);
							}
							float amount = 0;
							if (type == 2) {
								if(discountprice > 0f){
									content.append("折扣:" + fnum.format(discountprice) + "元<BR>");
								}
								if (order.getMoling() > 0) {
									content.append("抹零:" + fnum.format(order.getMoling()) + "元<BR>");
								}
								if (order.getCoupon_id() != null && order.getCoupon_id() > 0) {
									MyCoupon mycoupon = dataDao.getObjectById(MyCoupon.class, order.getCoupon_id());
									Coupon coupon = mycoupon.getCoupon();
									amount = coupon.getAmount();
									content.append("优惠券:" + fnum.format(amount) + "元<BR>");
								}
							}
							content.append("------------------------------------------------<BR>");
							StoreSigner storesigner = dataDao.getObjectById(StoreSigner.class, order.getSigner_id());
							switch (order.getPay_type()) {
							case 1:
								if (order.getActually_pay() != null) {
									content.append("现金支付:" + fnum.format(order.getActually_pay()) + "元<BR>");
									if (order.getActually_pay() - (order.getTotal_price() - order.getMoling() - discountprice - amount) > 0)
										content.append("找零:" + fnum.format(order.getActually_pay() - (order.getTotal_price() - order.getMoling() - discountprice - amount)) + "元<BR>");
								}
								break;
							case 2:
								content.append("支付宝支付:" + fnum.format(order.getPrice()) + "<BR>");
								break;
							case 3:
								content.append("刷卡支付:" + fnum.format(order.getPrice()) + "<BR>");
								break;
							case 4:
								content.append("充值卡" + order.getCard_no() + "支付:" + fnum.format(order.getPrice()) + "<BR>");
								break;
							case 5:
								if (storesigner != null)
									content.append("签单:" + storesigner.getName() + "<BR>");
								break;
							case 6:
								if (storesigner != null)
									content.append("免单" + storesigner.getName() + "<BR>");
								break;
							default:
								break;
							}
							CommonUtils.sendOrderPrint(printinfo.getPrint_sn(), printinfo.getPrint_key(), content.toString(), "" + (printinfo.getPrint_num() == null ? 1 : printinfo.getPrint_num()));
						}
					}
				}
			}
		}
		return null;
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public String sendOrderDetailPrint(long order_id) {
		Order order = dataDao.getObjectById(Order.class, order_id);
		if (order != null) {
			Store store = dataDao.getObjectById(Store.class, order.getStore_id());
			StoreTable table = dataDao.getObjectById(StoreTable.class, order.getTable_id());
			if (order.getIs_out() == 0) {
				if (table == null) {
					return null;
				}
				StoreArea storearea = dataDao.getObjectById(StoreArea.class, table.getArea_id());
				if (storearea == null) {
					return null;
				}
			}

			String detail1hql = " from OrderDetail where menu_id in ( select menu_id from Menu where (print_id1 = :print_id or print_id2 = :print_id or print_id3 = :print_id) ) and order_id = :order_id and detail_flg >= 0 ";
			String print1hql = " from PrintInfo where id in ( select distinct print_id1 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0  ) ) and scope = 4";
			String print2hql = " from PrintInfo where id in ( select distinct print_id2 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0  ) ) and scope = 4";
			String print3hql = " from PrintInfo where id in ( select distinct print_id3 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0  ) ) and scope = 4";
			List<PrintInfo> print1list = (List<PrintInfo>) dataDao.getObjectsViaParam(print1hql, new String[] { "order_id" }, order_id);
			List<PrintInfo> print2list = (List<PrintInfo>) dataDao.getObjectsViaParam(print2hql, new String[] { "order_id" }, order_id);
			List<PrintInfo> print3list = (List<PrintInfo>) dataDao.getObjectsViaParam(print3hql, new String[] { "order_id" }, order_id);
			HashSet<PrintInfo> printset = new HashSet<PrintInfo>();
			printset.addAll(print1list);
			printset.addAll(print2list);
			printset.addAll(print3list);
			for (PrintInfo print : printset) {
				StringBuffer content = new StringBuffer();
				content.append("<C>" + store.getStore_name() + " 传菜单</C><BR>");
				if (order.getIs_out() == 0) {
					content.append("<B>台号:" + table.getTable_no() + "</B><BR>");
				} else {
					content.append("<B>地址:" + order.getAddress() + "</B><BR>");
				}
				content.append("人数:" + order.getPeople_num() + " " + (order.getIs_out() == 0 ? "堂食" : "外卖") + "<BR>");
				content.append("下单人:" + (CommonUtils.isEmptyString(order.getOrder_name()) ? "" : order.getOrder_name()) + "<BR>");
				content.append("手机号码:" + (CommonUtils.isEmptyString(order.getPhone()) ? "" : order.getPhone()) + "<BR>");
				content.append("下单时间:" + CommonUtils.getTimeFormat(order.getOrder_time(), null) + "<BR>");
				if (print.getType() == 1) {
					content.append("--------------------------------<BR>");
				} else if (print.getType() == 2) {
					content.append("------------------------------------------------<BR>");
				}
				List<OrderDetail> detaillist = (List<OrderDetail>) dataDao.getObjectsViaParam(detail1hql, new String[] { "print_id", "print_id", "print_id", "order_id" }, print.getId(), print.getId(),
						print.getId(), order_id);
				for (OrderDetail detail : detaillist) {
					if (detail.getIs_weigh() == 0) {
						content.append("<B>" + detail.getQuantity() + " " + (CommonUtils.isEmptyString(detail.getKitunit()) ? detail.getUnit() : detail.getKitunit()) + "X" + detail.getMenu_name()
								+ " " + (CommonUtils.isEmptyString(detail.getTaste()) ? "" : detail.getTaste()) + "</B><BR>");
					} else {
						content.append("<B>" + detail.getQuantity() * detail.getWeight() + " " + (CommonUtils.isEmptyString(detail.getKitunit()) ? detail.getUnit() : detail.getKitunit()) + "X"
								+ detail.getMenu_name() + " " + (CommonUtils.isEmptyString(detail.getTaste()) ? "" : detail.getTaste()) + "</B><BR>");
					}
				}
				if(!CommonUtils.isEmptyString(order.getComment()))
				content.append("<BR>备注:" + order.getComment() + "<BR>");
				System.out.println(CommonUtils.sendOrderPrint(print.getPrint_sn(), print.getPrint_key(), content.toString(), "" + (print.getPrint_num() == null ? 1 : print.getPrint_num())));
			}
		}
		return null;
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public String sendOrderDetailSingelPrint(long order_id) {
		Order order = dataDao.getObjectById(Order.class, order_id);
		if (order != null) {
			Store store = dataDao.getObjectById(Store.class, order.getStore_id());
			StoreTable table = dataDao.getObjectById(StoreTable.class, order.getTable_id());
			if (order.getIs_out() == 0) {
				if (table == null) {
					return null;
				}
				StoreArea storearea = dataDao.getObjectById(StoreArea.class, table.getArea_id());
				if (storearea == null) {
					return null;
				}
			}
			String detail1hql = " from OrderDetail where menu_id in ( select menu_id from Menu where (print_id1 = :print_id or print_id2 = :print_id or print_id3 = :print_id) ) and order_id = :order_id and detail_flg >= 0 ";
			String print1hql = " from PrintInfo where id in ( select distinct print_id1 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0 ) ) and scope = 5";
			String print2hql = " from PrintInfo where id in ( select distinct print_id2 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0 ) ) and scope = 5";
			String print3hql = " from PrintInfo where id in ( select distinct print_id3 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0 ) ) and scope = 5";
			List<PrintInfo> print1list = (List<PrintInfo>) dataDao.getObjectsViaParam(print1hql, new String[] { "order_id" }, order_id);
			List<PrintInfo> print2list = (List<PrintInfo>) dataDao.getObjectsViaParam(print2hql, new String[] { "order_id" }, order_id);
			List<PrintInfo> print3list = (List<PrintInfo>) dataDao.getObjectsViaParam(print3hql, new String[] { "order_id" }, order_id);
			HashSet<PrintInfo> printset = new HashSet<PrintInfo>();
			printset.addAll(print1list);
			printset.addAll(print2list);
			printset.addAll(print3list);
			for (PrintInfo print : printset) {
				List<OrderDetail> detaillist = (List<OrderDetail>) dataDao.getObjectsViaParam(detail1hql, new String[] { "print_id", "print_id", "print_id", "order_id" }, print.getId(), print.getId(),
						print.getId(), order_id);
				for (OrderDetail detail : detaillist) {
					StringBuffer content = new StringBuffer();
//					content.append("<C>" + store.getStore_name() + " 传菜单</C><BR>");
					if (order.getIs_out() == 0) {
						content.append("<B>台号:" + table.getTable_no() + "</B><BR>");
					} else {
						content.append("<B>地址:" + order.getAddress() + "</B><BR>");
					}
//					content.append("人数:" + order.getPeople_num() + " " + (order.getIs_out() == 0 ? "堂食" : "外卖") + "<BR>");
					content.append("下单人:" + (CommonUtils.isEmptyString(order.getOrder_name()) ? "" : order.getOrder_name()) + "<BR>");
					content.append("手机号码:" + (CommonUtils.isEmptyString(order.getPhone()) ? "" : order.getPhone()) + "<BR>");
					content.append("下单时间:" + CommonUtils.getTimeFormat(order.getOrder_time(), null) + "<BR>");
					if (print.getType() == 1) {
						content.append("--------------------------------<BR>");
					} else if (print.getType() == 2) {
						content.append("------------------------------------------------<BR>");
					}
					if (detail.getIs_weigh() == 0) {
						content.append("<B>" + detail.getQuantity() + " " + (CommonUtils.isEmptyString(detail.getKitunit()) ? detail.getUnit() : detail.getKitunit()) + "X" + detail.getMenu_name()
								+ " </B><BR><B>" + (CommonUtils.isEmptyString(detail.getTaste()) ? "" : detail.getTaste()) + "</B><BR>");
					} else {
						content.append("<B>" + detail.getQuantity() * detail.getWeight() + " " + (CommonUtils.isEmptyString(detail.getKitunit()) ? detail.getUnit() : detail.getKitunit()) + "X"
								+ detail.getMenu_name() + " </B><BR><B>" + (CommonUtils.isEmptyString(detail.getTaste()) ? "" : detail.getTaste()) + "</B><BR>");
					}
					if(!CommonUtils.isEmptyString(order.getComment()))
					content.append("<BR>备注:" + order.getComment() + "<BR>");
					System.out.println(CommonUtils.sendOrderPrint(print.getPrint_sn(), print.getPrint_key(), content.toString(), "" + (print.getPrint_num() == null ? 1 : print.getPrint_num())));
				}
			}
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void changeTablePrint(long from_table,long to_table,Long userid) {
		StoreTable fromtable = dataDao.getObjectById(StoreTable.class, from_table);
		StoreArea fromarea = dataDao.getObjectById(StoreArea.class, fromtable.getArea_id());
		StoreTable totable = dataDao.getObjectById(StoreTable.class, to_table);
		StoreArea toarea = dataDao.getObjectById(StoreArea.class, totable.getArea_id());
		StoreUser storeuser = null;
		if(userid!=null&&userid>0){
			storeuser = dataDao.getObjectById(StoreUser.class, userid);
		}
		if(fromtable!=null&&totable!=null&&fromtable.getStore_id()==totable.getStore_id()){
		String hql = "from PrintInfo where store_id = :store_id"; 
		List<PrintInfo> printlist = (List<PrintInfo>) dataDao.getObjectsViaParam(hql, new String[]{"store_id"}, fromtable.getStore_id());
			for(PrintInfo print:printlist){
				StringBuffer content = new StringBuffer();
				content.append("<CB>换台单</CB><BR>");
				if(print.getType()==1){
					content.append("--------------------------------<BR>");
				}else{
					content.append("------------------------------------------------<BR>");
				}
				content.append("<CB>"+fromarea.getArea_name()+"-"+fromtable.getTable_no()+" 换台 "+toarea.getArea_name()+"-"+totable.getTable_no()+"</CB><BR>");
				content.append("时间:"+CommonUtils.getTimeFormat(new Date(), "yyyy.MM.dd HH:mm")+"<BR>");
				content.append("操作员:"+(storeuser==null?"":storeuser.getName())+"<BR>");
				content.append("服务员:");
				CommonUtils.sendOrderPrint(print.getPrint_sn(), print.getPrint_key(), content.toString(), "1");
			}
		}
		
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addDetailPrint(long order_id, List<OrderDetail> orderdetails) {
		Order order = dataDao.getObjectById(Order.class, order_id);
		if (order != null) {
			Store store = dataDao.getObjectById(Store.class, order.getStore_id());
			StoreTable table = dataDao.getObjectById(StoreTable.class, order.getTable_id());
			if (table != null) {
				StoreArea storearea = dataDao.getObjectById(StoreArea.class, table.getArea_id());
				if (storearea != null) {
					String print1hql = " from PrintInfo where id in ( select distinct print_id1 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0 ) ) and scope = 4";
					String print2hql = " from PrintInfo where id in ( select distinct print_id2 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0 ) ) and scope = 4";
					String print3hql = " from PrintInfo where id in ( select distinct print_id3 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0 ) ) and scope = 4";
					List<PrintInfo> print1list = (List<PrintInfo>) dataDao.getObjectsViaParam(print1hql, new String[] { "order_id" }, order_id);
					List<PrintInfo> print2list = (List<PrintInfo>) dataDao.getObjectsViaParam(print2hql, new String[] { "order_id" }, order_id);
					List<PrintInfo> print3list = (List<PrintInfo>) dataDao.getObjectsViaParam(print3hql, new String[] { "order_id" }, order_id);
					HashSet<PrintInfo> printset = new HashSet<PrintInfo>();
					printset.addAll(print1list);
					printset.addAll(print2list);
					printset.addAll(print3list);
					for (PrintInfo print : printset) {
						StringBuffer content = new StringBuffer();
						content.append("<C>" + store.getStore_name() + " 加菜单</C><BR>");
						content.append("<B>台号:" + table.getTable_no() + "</B><BR>");
						content.append("人数:" + order.getPeople_num() + " " + (order.getIs_out() == 0 ? "堂食" : "外卖") + "<BR>");
						content.append("下单人:" + (CommonUtils.isEmptyString(order.getOrder_name()) ? "" : order.getOrder_name()) + "<BR>");
						content.append("手机号码:" + (CommonUtils.isEmptyString(order.getPhone()) ? "" : order.getPhone()) + "<BR>");
						content.append("下单时间:" + CommonUtils.getTimeFormat(order.getOrder_time(), null) + "<BR>");
						if (print.getType() == 1) {
							content.append("--------------------------------<BR>");
						} else if (print.getType() == 2) {
							content.append("------------------------------------------------<BR>");
						}
						for (OrderDetail detail : orderdetails) {
							if (detail.getIs_weigh() == 0) {
								content.append("<B>" + detail.getQuantity() + " " + (CommonUtils.isEmptyString(detail.getKitunit()) ? detail.getUnit() : detail.getKitunit()) + "X"
										+ detail.getMenu_name() + " " + (CommonUtils.isEmptyString(detail.getTaste()) ? "" : detail.getTaste()) + "</B><BR>");
							} else {
								content.append("<B>" + detail.getQuantity() * detail.getWeight() + " " + (CommonUtils.isEmptyString(detail.getKitunit()) ? detail.getUnit() : detail.getKitunit()) + "X"
										+ detail.getMenu_name() + " " + (CommonUtils.isEmptyString(detail.getTaste()) ? "" : detail.getTaste()) + "</B><BR>");
							}
						}
						if(!CommonUtils.isEmptyString(order.getComment()))
						content.append("<BR>备注:" + order.getComment() + "<BR>");
						CommonUtils.sendOrderPrint(print.getPrint_sn(), print.getPrint_key(), content.toString(), "" + (print.getPrint_num() == null ? 1 : print.getPrint_num()));
					}

					String singelprint1hql = " from PrintInfo where id in ( select distinct print_id1 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0 ) ) and scope = 5";
					String singelprint2hql = " from PrintInfo where id in ( select distinct print_id2 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0 ) ) and scope = 5";
					String singelprint3hql = " from PrintInfo where id in ( select distinct print_id3 from Menu where  menu_id in( select menu_id from OrderDetail where  order_id = :order_id and detail_flg >= 0 ) ) and scope = 5";
					List<PrintInfo> singelprint1list = (List<PrintInfo>) dataDao.getObjectsViaParam(singelprint1hql, new String[] { "order_id" }, order_id);
					List<PrintInfo> singelprint2list = (List<PrintInfo>) dataDao.getObjectsViaParam(singelprint2hql, new String[] { "order_id" }, order_id);
					List<PrintInfo> singelprint3list = (List<PrintInfo>) dataDao.getObjectsViaParam(singelprint3hql, new String[] { "order_id" }, order_id);
					HashSet<PrintInfo> singelprintset = new HashSet<PrintInfo>();
					singelprintset.addAll(singelprint1list);
					singelprintset.addAll(singelprint2list);
					singelprintset.addAll(singelprint3list);
					for (PrintInfo print : singelprintset) {
						for (OrderDetail detail : orderdetails) {
							StringBuffer content = new StringBuffer();
							content.append("<C>" + store.getStore_name() + " 加菜单</C><BR>");
							content.append("<B>台号:" + table.getTable_no() + "</B><BR>");
							content.append("人数:" + order.getPeople_num() + " " + (order.getIs_out() == 0 ? "堂食" : "外卖") + "<BR>");
							content.append("下单人:" + (CommonUtils.isEmptyString(order.getOrder_name()) ? "" : order.getOrder_name()) + "<BR>");
							content.append("手机号码:" + (CommonUtils.isEmptyString(order.getPhone()) ? "" : order.getPhone()) + "<BR>");
							content.append("下单时间:" + CommonUtils.getTimeFormat(order.getOrder_time(), null) + "<BR>");
							if (print.getType() == 1) {
								content.append("--------------------------------<BR>");
							} else if (print.getType() == 2) {
								content.append("------------------------------------------------<BR>");
							}
							if (detail.getIs_weigh() == 0) {
								content.append("<B>" + detail.getQuantity() + " " + (CommonUtils.isEmptyString(detail.getKitunit()) ? detail.getUnit() : detail.getKitunit()) + "X"
										+ detail.getMenu_name() + " </B><BR><B>" + (CommonUtils.isEmptyString(detail.getTaste()) ? "" : detail.getTaste()) + "</B><BR>");
							} else {
								content.append("<B>" + detail.getQuantity() * detail.getWeight() + " " + (CommonUtils.isEmptyString(detail.getKitunit()) ? detail.getUnit() : detail.getKitunit()) + "X"
										+ detail.getMenu_name() + " </B><BR><B>" + (CommonUtils.isEmptyString(detail.getTaste()) ? "" : detail.getTaste()) + "</B><BR>");
							}
							if(!CommonUtils.isEmptyString(order.getComment()))
							content.append("<BR>备注:" + order.getComment() + "<BR>");
							CommonUtils.sendOrderPrint(print.getPrint_sn(), print.getPrint_key(), content.toString(), "" + (print.getPrint_num() == null ? 1 : print.getPrint_num()));
						}
					}
					PrintInfo printinfo1 = dataDao.getObjectById(PrintInfo.class, storearea.getPrint_id1());
					PrintInfo printinfo2 = dataDao.getObjectById(PrintInfo.class, storearea.getPrint_id2());
					PrintInfo printinfo3 = dataDao.getObjectById(PrintInfo.class, storearea.getPrint_id3());
					List<PrintInfo> printlist = new ArrayList<PrintInfo>();
					if (printinfo1 != null && printinfo1.getScope() != null && (printinfo1.getScope() == 1 || printinfo1.getScope() == 2))
						printlist.add(printinfo1);
					if (printinfo2 != null && printinfo2.getScope() != null && (printinfo2.getScope() == 1 || printinfo2.getScope() == 2))
						printlist.add(printinfo2);
					if (printinfo3 != null && printinfo3.getScope() != null && (printinfo3.getScope() == 1 || printinfo3.getScope() == 2))
						printlist.add(printinfo3);
					for(PrintInfo printinfo:printlist){
						StringBuffer content = new StringBuffer();
						// 标签说明："<BR>"为换行符,"<CB></CB>"为居中放大,"<B></B>"为放大,"<C></C>"为居中,<L></L>字体变高
						// "<QR></QR>"为二维码,"<CODE>"为条形码,后面接12个数字
						DecimalFormat fnum = new DecimalFormat("#0.00");
						if (printinfo.getType() == 1) {
							content.append("<C>" + store.getStore_name() + " 预结单</C><BR>");
							content.append("<B>台号:" + table.getTable_no() + "</B><BR>人数:" + order.getPeople_num() + "<BR>");
							content.append("下单人:" + (CommonUtils.isEmptyString(order.getOrder_name()) ? "" : order.getOrder_name()) + "<BR>");
							content.append("下单时间:" + CommonUtils.getTimeFormat(order.getOrder_time(), null) + "<BR>");
							content.append("--------------------------------<BR>");
							content.append("名称　　　　　 单价  数量 金额<BR>");
							float allprice = 0f;
							for (OrderDetail orderdetail : orderdetails) {
								// 结账单打印全部菜品已经退菜品
								// 收银单只打印未退菜品
									if (CommonUtils.isEmptyString(orderdetail.getMenu_name())) {
										content.append(CommonUtils.textAppend(orderdetail.getMenu_name(), 8) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 7)
												+ CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 4));
										if (orderdetail.getIs_weigh() == 0) {
											content.append(fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									} else {
										String menu_name = orderdetail.getMenu_name();
										while (menu_name.length() > 7) {
											content.append(menu_name.substring(0, 7) + "<BR>");
											menu_name = menu_name.substring(7, menu_name.length());
										}
										content.append(CommonUtils.textAppend(menu_name, 8) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 7));
										if (orderdetail.getIs_weigh() == 0) {
											allprice += orderdetail.getPrice() * orderdetail.getQuantity();
											content.append(
													CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 4) + fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											allprice += orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight();
											content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()), 4)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									}
							}
							content.append("--------------------------------<BR>");
							content.append("打印时间:" + CommonUtils.getTimeFormat(new Date(), null) + "<BR>");
							content.append("消费总额:" + fnum.format(allprice) + "元<BR>");
							content.append("--------------------------------<BR>");
							CommonUtils.sendOrderPrint(printinfo.getPrint_sn(), printinfo.getPrint_key(), content.toString(), "" + (printinfo.getPrint_num() == null ? 1 : printinfo.getPrint_num()));
						} else if (printinfo.getType() == 2) {
							content.append("<C>" + store.getStore_name() + " 预结单</C><BR>");
							content.append("<B>台号:" + table.getTable_no() + "</B><BR>人数:" + order.getPeople_num() + "<BR>");
							content.append("下单人:" + (CommonUtils.isEmptyString(order.getOrder_name()) ? "" : order.getOrder_name()) + "<BR>");
							content.append("下单时间:" + CommonUtils.getTimeFormat(order.getOrder_time(), null) + "<BR>");
							content.append("------------------------------------------------<BR>");
							content.append("名称　　　　　　　　　 单价     数量      金额<BR>");
							float allprice = 0f;
							for (OrderDetail orderdetail : orderdetails) {
									if (CommonUtils.isEmptyString(orderdetail.getMenu_name())) {
										content.append(CommonUtils.textAppend(orderdetail.getMenu_name(), 12) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 9));
										if (orderdetail.getIs_weigh() == 0) {
											content.append(
													CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()), 9) + fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()), 9)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									} else {
										String menu_name = orderdetail.getMenu_name();
										while (menu_name.length() > 11) {
											content.append(menu_name.substring(0, 11) + "<BR>");
											menu_name = menu_name.substring(11, menu_name.length());
										}
										content.append(CommonUtils.textAppend(menu_name, 12) + CommonUtils.numberAppend(fnum.format(orderdetail.getPrice()), 9));

										if (orderdetail.getIs_weigh() == 0) {
											allprice += orderdetail.getPrice() * orderdetail.getQuantity();
											content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity()) + orderdetail.getUnit(), 9)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity()) + "<BR>");
										} else if (orderdetail.getIs_weigh() == 1) {
											allprice += orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight();
											content.append(CommonUtils.numberAppend(String.valueOf(orderdetail.getQuantity() * orderdetail.getWeight()) + orderdetail.getUnit(), 9)
													+ fnum.format(orderdetail.getPrice() * orderdetail.getQuantity() * orderdetail.getWeight()) + "<BR>");
										}
									}
							}
//							content.append("备注:" + order.getComment() + "<BR>");
							content.append("------------------------------------------------<BR>");
							content.append("打印时间:" + CommonUtils.getTimeFormat(new Date(), null) + "<BR>");
							content.append("消费总额:" + fnum.format(allprice) + "元<BR>");
							content.append("------------------------------------------------<BR>");
							CommonUtils.sendOrderPrint(printinfo.getPrint_sn(), printinfo.getPrint_key(), content.toString(), "" + (printinfo.getPrint_num() == null ? 1 : printinfo.getPrint_num()));
						}
					}
				}
			}
		}
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delOrderDetailPrint(long detail_id) {
		OrderDetail orderdetail = dataDao.getObjectById(OrderDetail.class, detail_id);
		if (orderdetail != null) {
			Menu menu = dataDao.getObjectById(Menu.class, orderdetail.getMenu_id());
			if (menu != null) {
				HashSet<PrintInfo> printlist = new HashSet<PrintInfo>();
				PrintInfo printinfo1 = dataDao.getObjectById(PrintInfo.class, menu.getPrint_id1());
				PrintInfo printinfo2 = dataDao.getObjectById(PrintInfo.class, menu.getPrint_id2());
				PrintInfo printinfo3 = dataDao.getObjectById(PrintInfo.class, menu.getPrint_id3());
				if (printinfo1 != null && printinfo1.getScope() != null && (printinfo1.getScope() == 1 || printinfo1.getScope() == 5))
					printlist.add(printinfo1);
				if (printinfo2 != null && printinfo2.getScope() != null && (printinfo2.getScope() == 1 || printinfo2.getScope() == 5))
					printlist.add(printinfo2);
				if (printinfo3 != null && printinfo3.getScope() != null && (printinfo3.getScope() == 1 || printinfo3.getScope() == 5))
					printlist.add(printinfo3);
				Order order = dataDao.getObjectById(Order.class, orderdetail.getOrder_id());
				Store store = dataDao.getObjectById(Store.class, order.getStore_id());
				StoreTable table = dataDao.getObjectById(StoreTable.class, order.getTable_id());
				for (PrintInfo print : printlist) {
					StringBuffer content = new StringBuffer();
					content.append("<C>" + store.getStore_name() + " 退菜单</C><BR>");
					if (order.getIs_out() == 0) {
						content.append("<B>台号:" + table.getTable_no() + "</B><BR>");
					}
					content.append("人数:" + order.getPeople_num() + " " + (order.getIs_out() == 0 ? "堂食" : "外卖") + "<BR>");
					content.append("退单人:" + (CommonUtils.isEmptyString(order.getOrder_name()) ? "" : order.getOrder_name()) + "<BR>");
					content.append("退单时间:" + CommonUtils.getTimeFormat(order.getOrder_time(), null) + "<BR>");
					if (print.getType() == 1) {
						content.append("--------------------------------<BR>");
					} else if (print.getType() == 2) {
						content.append("------------------------------------------------<BR>");
					}
					if (orderdetail.getIs_weigh() == 0) {
						content.append("<B>-" + orderdetail.getQuantity() + " " + (CommonUtils.isEmptyString(orderdetail.getKitunit()) ? orderdetail.getUnit() : orderdetail.getKitunit()) + "X"
								+ orderdetail.getMenu_name() + " " + (CommonUtils.isEmptyString(orderdetail.getTaste()) ? "" : orderdetail.getTaste()) + "</B><BR>");
					} else {
						content.append("<B>-" + orderdetail.getQuantity() * orderdetail.getWeight() + " "
								+ (CommonUtils.isEmptyString(orderdetail.getKitunit()) ? orderdetail.getUnit() : orderdetail.getKitunit()) + "X" + orderdetail.getMenu_name() + " "
								+ (CommonUtils.isEmptyString(orderdetail.getTaste()) ? "" : orderdetail.getTaste()) + "</B><BR>");
					}
					CommonUtils.sendOrderPrint(print.getPrint_sn(), print.getPrint_key(), content.toString(), "" + (print.getPrint_num() == null ? 1 : print.getPrint_num()));
				}
			}
		}
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void accountDaily(long order_id) {
		Order order = dataDao.getObjectById(Order.class, order_id);
		if (order != null && order.getState() == 4) {
			Store store = dataDao.getObjectById(Store.class, order.getStore_id());
			if (store != null) {
				String hql = " from DailyStatistics where store_id = :store_id  ";
				DailyStatistics dailyStatistics = (DailyStatistics) dataDao.getFirstObjectViaParam(hql, new String[] { "store_id" }, order.getStore_id());
				if (dailyStatistics == null) {
					dailyStatistics = new DailyStatistics();
					dailyStatistics.setTotal_customers(0);
					dailyStatistics.setTotal_order(0);
					dailyStatistics.setTotal_sell(0);
					dailyStatistics.setPaypal_num(0);
					dailyStatistics.setCard_num(0);
					dailyStatistics.setCash_num(0);
					dailyStatistics.setCharge_num(0);
				}
				dailyStatistics.setTotal_customers(dailyStatistics.getTotal_customers() + order.getPeople_num());
				dailyStatistics.setTotal_order(dailyStatistics.getTotal_order() + 1);
				dailyStatistics.setTotal_sell(dailyStatistics.getTotal_sell() + order.getPrice());
				switch (order.getPay_type()) {
				case 1:
					dailyStatistics.setCash_num(dailyStatistics.getCash_num() + order.getPrice());
					break;
				case 2:
					dailyStatistics.setPaypal_num(dailyStatistics.getPaypal_num() + order.getPrice());
					break;
				case 3:
					dailyStatistics.setCard_num(dailyStatistics.getCard_num() + order.getPrice());
					break;
				case 4:
					dailyStatistics.setCharge_num(dailyStatistics.getCharge_num() + order.getPrice());
					break;
				}
				dataDao.saveOrUpdateObject(dailyStatistics);
			}
		}
	}

}
