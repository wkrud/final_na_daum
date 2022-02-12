package com.project.nadaum.accountbook.model.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.project.nadaum.accountbook.model.vo.AccountBook;
import com.project.nadaum.accountbook.model.vo.AccountBookChart;

public interface AccountBookService {

	int insertAccount(AccountBook account);

	List<AccountBook> selectAllAccountList(Map<String, Object> param);

	int deleteAccount(Map<String, Object> code);

//	List<Map<String, Object>> monthlyTotalIncome(String id);
	List<Map<String, Object>> monthlyTotalIncome(Map<String, Object> param);

	String monthlyAccount(Map<String, Object> param);

	List<AccountBook> incomeExpenseFilter(Map<String, Object> map);

	List<AccountBook> searchList(Map<String, Object> map);

	List<Map<String,Object>> chartValue(Map<String, Object> param);

	int countAccountList(Map<String, Object> param);

	List<Map<String,Object>> detailMonthlyChart(Map<String, Object> map);

	List<AccountBook> monthlyCountList(Map<String, Object> param);

	List<Map<String, Object>> categoryChart(Map<String, Object> map);

	List<Map<String, Object>> paymentList(Map<String, Object> param);

	List<AccountBook> downloadExcel(Map<String, Object> map);

	List<AccountBook> selectOneAccount(Map<String, Object> param);

	int updateAccount(AccountBook account);

	String searchToday(Map<String, Object> param);



}
