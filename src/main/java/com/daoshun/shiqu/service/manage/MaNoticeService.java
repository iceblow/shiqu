/**
 * 
 */
package com.daoshun.shiqu.service.manage;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.shiqu.service.BaseService;

/**
 *  后台管理公告Service
 * @author qiuch
 *
 */
@Service("maNoticeService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class MaNoticeService extends BaseService {}
