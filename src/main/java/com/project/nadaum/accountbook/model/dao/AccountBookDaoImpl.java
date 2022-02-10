package com.project.nadaum.accountbook.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.accountbook.model.vo.AccountBook;
import com.project.nadaum.accountbook.model.vo.AccountBookChart;

@Repository
public class AccountBookDaoImpl implements AccountBookDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertAccount(AccountBook account) {
		return session.insert("accountbook.insertAccount", account);
	}

	@Override
	public List<AccountBook> selectAllAccountList(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("accountbook.selectAllAccountList", param, rowBounds);
	}

	@Override
	public int deleteAccount(Map<String, Object> code) {
		return session.delete("accountbook.deleteAccount", code);
	}

	@Override
	public List<Map<String, Object>> monthlyTotalIncome(String id) {
		return session.selectList("accountbook.monthlyTotalIncome", id);
	}

	@Override
	public String monthlyAccount(String id) {
		return session.selectOne("accountbook.monthlyAccount", id);
	}

	@Override
	public List<AccountBook> incomeExpenseFilter(Map<String, Object> map) {
		int offset = (int) map.get("offset");
		int limit = (int) map.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("accountbook.incomeExpenseFilter", map, rowBounds);
	}

	@Override
	public List<AccountBook> searchList(Map<String, Object> map) {
		int offset = (int) map.get("offset");
		int limit = (int) map.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("accountbook.searchList", map, rowBounds);
	}


	@Override
	public List<Map<String,Object>> chartValue(Map<String,Object> param) {
		return session.selectList("accountbook.chartValue", param);
	}

	@Override
	public int countAccountList(Map<String, Object> param) {
		return session.selectOne("accountbook.countAccountList", param);
	}

	@Override
	public List<Map<String,Object>> detailMonthlyChart(Map<String, Object> map) {
		return session.selectList("accountbook.detailMonthlyChart", map);
	}

	@Override
	public List<AccountBook> monthlyCountList(Map<String, Object> param) {
		return session.selectList("accountbook.monthlyCountList", param);
	}

	@Override
	public List<Map<String, Object>> categoryChart(Map<String, Object> map) {
		return session.selectList("accountbook.categoryChart", map);
	}

	@Override
	public List<Map<String, Object>> paymentList(Map<String, Object> param) {
		return session.selectList("accountbook.paymentList", param);
	}

	@Override
	public List<AccountBook> downloadExcel(Map<String, Object> map) {
		return session.selectList("accountbook.downloadExcel", map);
	}
	
	


}
