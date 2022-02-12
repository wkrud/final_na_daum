package com.project.nadaum.accountbook.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nadaum.accountbook.AccountbookPagebar;
import com.project.nadaum.accountbook.model.service.AccountBookService;
import com.project.nadaum.accountbook.model.vo.AccountBook;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/accountbook")
public class AccountBookController {

	@Autowired
	private AccountBookService accountBookService;

	// 가계부 첫 화면에 보여질 값들
	@RequestMapping(value = "/accountbook.do")
	public void accountbook(@RequestParam(defaultValue = "1") int cPage, @AuthenticationPrincipal Member member,
			Model model, String date, HttpServletRequest request) {
		int limit = 4;
		int offset = (cPage - 1) * limit;
		String id = member.getId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		param.put("id", id);
		param.put("date", date);
		
		//이달의 월 조회
		String today = accountBookService.searchToday(param);
		// 로그인한 아이디로 등록된 가계부 전체 목록
		List<AccountBook> accountList = accountBookService.selectAllAccountList(param);

		// 전체리스트 개수
		int totalAccountList = accountBookService.countAccountList(param);

		String incomeExpense = "all";
		String category = "all";
		String detail = "all";
		String url = request.getRequestURI();
		String pagebar = AccountbookPagebar.getPagebar(cPage, limit, totalAccountList, url, incomeExpense, category,
				detail);

		model.addAttribute("pagebar", pagebar);

		// 수입, 지출 계산한 값
		List<Map<String, Object>> incomeList = accountBookService.monthlyTotalIncome(param);
		log.debug("incomeList={}", incomeList);
		// 필요한 값만 맵 객체로 변환
		Map<String, Object> incomeExpenseList = new HashMap<>();

		if (incomeList.size() == 0) {
			incomeExpenseList.put("income", 0);
			incomeExpenseList.put("expense", 0);
		} else if (incomeList.size() == 1) {
			if ((incomeList.get(0).get("incomeExpense")).equals("I")) {
				incomeExpenseList.put("income", incomeList.get(0).get("total"));
				incomeExpenseList.put("expense", 0);
			} else {
				incomeExpenseList.put("income", 0);
				incomeExpenseList.put("expense", incomeList.get(0).get("total"));
			}
		} else {
			incomeExpenseList.put("income", incomeList.get(1).get("total"));
			incomeExpenseList.put("expense", incomeList.get(0).get("total"));
		}

		log.info("incomeExpenseList={}", incomeExpenseList);

		// 월간 총 합계 금액
		String monthlyAccount = accountBookService.monthlyAccount(param);
		// 만약 사용자 입력값이 없어서 monthlyAccount합계가 null값이 넘어온다면 해당 변수에 0 대입
		if (monthlyAccount == null) {
			monthlyAccount = "0";
		}
		log.info("monthlyAccount={}", monthlyAccount);

		model.addAttribute("accountList", accountList);
		model.addAttribute("incomeExpenseList", incomeExpenseList);
		model.addAttribute("monthlyAccount", monthlyAccount);
		model.addAttribute("totalAccountList", totalAccountList);
		model.addAttribute("today", today);
	}

	// 차트 더보기 페이지
	@RequestMapping(value = "/accountAnalyze.do")
	public void detailChartData(@RequestParam(defaultValue = "0") int monthly, @AuthenticationPrincipal Member member,
			String date, Model model) {
		// 수입
		Map<String, Object> param = new HashMap<>();
		param.put("monthly", monthly);
		param.put("id", member.getId());
		param.put("incomeExpense", "I");
		param.put("date", date);
		
		//이달의 월 조회
		String today = accountBookService.searchToday(param);
				
		// 수입 카테고리 베스트3
		List<Map<String, Object>> categoryList_I = accountBookService.categoryChart(param);
		// 현금/카드 건수
		List<Map<String, Object>> paymentList_I = accountBookService.paymentList(param);

		// 지출
		Map<String, Object> param2 = new HashMap<>();
		param2.put("monthly", monthly);
		param2.put("id", member.getId());
		param2.put("incomeExpense", "E");
		param2.put("date", date);
		// 지출 카테고리 베스트3
		List<Map<String, Object>> categoryList_E = accountBookService.categoryChart(param2);
		log.debug("Clist_E={}", categoryList_E);
		// 현금, 카드 건수
		List<Map<String, Object>> paymentList_E = accountBookService.paymentList(param2);

		model.addAttribute("categoryList_I", categoryList_I);
		model.addAttribute("categoryList_E", categoryList_E);
		model.addAttribute("paymentList_I", paymentList_I);
		model.addAttribute("paymentList_E", paymentList_E);
		model.addAttribute("today", today);
	}

	// 전체 리스트 출력
	@RequestMapping(value = "/selectAllAccountList.do")
	public void selectAllAccountList(@AuthenticationPrincipal Member member, Model model, HttpServletRequest request) {
		String id = member.getId();
		Map<String, Object> param = new HashMap<>();
		param.put("id", id);
		// 로그인한 아이디로 등록된 가계부 전체 목록
		List<AccountBook> accountList = accountBookService.selectAllAccountList(param);

		model.addAttribute("accountList", accountList);
	}

	// 단일 리스트 출력
	@ResponseBody
	@GetMapping(value = "/selectOneAccount")
	public List<AccountBook> selectOneAccount(@AuthenticationPrincipal Member member, Model model, @RequestParam String code) {
		String id = member.getId();
		Map<String, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("code", code);

		List<AccountBook> accountOneList = accountBookService.selectOneAccount(param);
		log.info("accountOneList={}", accountOneList);
		
		return accountOneList;
	}

	// 가계부 추가
	@RequestMapping(value = "/accountInsert.do", method = RequestMethod.POST)
	public String insertAccount(AccountBook account) {
		int result = accountBookService.insertAccount(account);

		return "redirect:/accountbook/accountbook.do";
	}

	// 가계부 삭제
	@ResponseBody
	@RequestMapping(value = "/accountDelete.do", method = RequestMethod.POST)
	public Map<String, Object> deleteAccount(@RequestBody Map<String, Object> code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code.get("code"));
		int result = accountBookService.deleteAccount(map);
		return map;
	}
	
	//가계부 수정
	@ResponseBody
	@PostMapping(value="/updateAccount.do")
	public String updateAccount(AccountBook account) {
		log.debug("account={}", account);
		int result = accountBookService.updateAccount(account);
		
		return "redirect:/accountbook/accountbook.do";
	}

	// 수입, 지출별 정렬
	@GetMapping(value = "/incomeExpenseFilter.do")
	public String incomeExpenseFilter(@RequestParam(defaultValue = "1") int cPage,
			@AuthenticationPrincipal Member member, String incomeExpense, Model model, 
			String date, HttpServletRequest request) {
		int limit = 4;
		int offset = (cPage - 1) * limit;
		String id = member.getId();

		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("incomeExpense", incomeExpense);
		map.put("offset", offset);
		map.put("limit", limit);
		map.put("date", date);
		// 조회한 목록
		List<AccountBook> accountList = accountBookService.incomeExpenseFilter(map);
		log.debug("incomeExpense={}", incomeExpense);
		// 조회한 목록 전체 개수
		int totalAccountList = accountBookService.countAccountList(map);
		// 페이지바
		String category = "all";
		String detail = "all";
		String url = request.getRequestURI();
		String pagebar = AccountbookPagebar.getPagebar(cPage, limit, totalAccountList, url, incomeExpense, category,
				detail);

		// 수입, 지출 계산한 값
		List<Map<String, Object>> incomeList = accountBookService.monthlyTotalIncome(map);
		// 필요한 값만 맵 객체로 변환
		Map<String, Object> incomeExpenseList = new HashMap<>();
		if (incomeList.size() == 0) {
			incomeExpenseList.put("income", 0);
			incomeExpenseList.put("expense", 0);
		} else if (incomeList.size() == 1) {
			if ((incomeList.get(0).get("incomeExpense")).equals("I")) {
				incomeExpenseList.put("income", incomeList.get(0).get("total"));
				incomeExpenseList.put("expense", 0);
			} else {
				incomeExpenseList.put("income", 0);
				incomeExpenseList.put("expense", incomeList.get(0).get("total"));
			}
		} else {
			incomeExpenseList.put("income", incomeList.get(1).get("total"));
			incomeExpenseList.put("expense", incomeList.get(0).get("total"));
		}
		log.info("incomeExpenseList={}", incomeExpenseList);

		// 월간 총 합계 금액
		String monthlyAccount = accountBookService.monthlyAccount(map);
		log.info("monthlyAccount={}", monthlyAccount);
		// 만약 사용자 입력값이 없어서 monthlyAccount합계가 null값이 넘어온다면 해당 변수에 0 대입
		if (monthlyAccount == null) {
			monthlyAccount = "0";
		}

		model.addAttribute("totalAccountList", totalAccountList);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("accountList", accountList);
		model.addAttribute("incomeExpenseList", incomeExpenseList);
		model.addAttribute("monthlyAccount", monthlyAccount);

		return "/accountbook/accountbook";
	}

	// 검색
	@GetMapping(value = "/searchList.do")
	public String searchList(@RequestParam(defaultValue = "1") int cPage, @AuthenticationPrincipal Member member,
			@RequestParam Map<String, Object> param, Model model, String date, HttpServletRequest request) {
		int limit = 4;
		int offset = (cPage - 1) * limit;
		String id = member.getId();
		String incomeExpense = (String) param.get("incomeExpense");
		String category = (String) param.get("category");
		String detail = (String) param.get("detail");

		Map<String, Object> map = new HashMap<>();
		map.put("incomeExpense", incomeExpense);
		map.put("category", category);
		map.put("detail", detail);
		map.put("id", member.getId());
		map.put("limit", limit);
		map.put("offset", offset);
		map.put("date", date);
		log.info("map={}", map);

		List<AccountBook> accountList = accountBookService.searchList(map);
		log.info("list={}", accountList);

		// 전체리스트 개수
		int totalAccountList = accountBookService.countAccountList(map);

		String url = request.getRequestURI();
		String pagebar = AccountbookPagebar.getPagebar(cPage, limit, totalAccountList, url, incomeExpense, category,
				detail);

		model.addAttribute("pagebar", pagebar);

		// 수입, 지출 계산한 값
		List<Map<String, Object>> incomeList = accountBookService.monthlyTotalIncome(map);
		// 필요한 값만 맵 객체로 변환
		Map<String, Object> incomeExpenseList = new HashMap<>();
		if (incomeList.size() == 0) {
			incomeExpenseList.put("income", 0);
			incomeExpenseList.put("expense", 0);
		} else if (incomeList.size() == 1) {
			if ((incomeList.get(0).get("incomeExpense")).equals("I")) {
				incomeExpenseList.put("income", incomeList.get(0).get("total"));
				incomeExpenseList.put("expense", 0);
			} else {
				incomeExpenseList.put("income", 0);
				incomeExpenseList.put("expense", incomeList.get(0).get("total"));
			}
		} else {
			incomeExpenseList.put("income", incomeList.get(1).get("total"));
			incomeExpenseList.put("expense", incomeList.get(0).get("total"));
		}
		log.info("incomeExpenseList={}", incomeExpenseList);

		// 월간 총 합계 금액
		String monthlyAccount = accountBookService.monthlyAccount(map);
		log.info("monthlyAccount={}", monthlyAccount);
		// 만약 사용자 입력값이 없어서 monthlyAccount합계가 null값이 넘어온다면 해당 변수에 0 대입
		if (monthlyAccount == null) {
			monthlyAccount = "0";
		}

		model.addAttribute("totalAccountList", totalAccountList);
		model.addAttribute("incomeExpenseList", incomeExpenseList);
		model.addAttribute("monthlyAccount", monthlyAccount);
		model.addAttribute("accountList", accountList);
		model.addAttribute("searchKeyword", map);

		return "/accountbook/accountbook";
	}

	// 차트
	@ResponseBody
	@PostMapping(value = "/incomeChart.do", produces = "application/json; charset=UTF-8")
	public List<Map<String, Object>> chartValue(@AuthenticationPrincipal Member member, @RequestBody Map<String, Object> param, Model model) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", member.getId());
		map.put("incomeExpense", param.get("incomeExpense"));
		map.put("date", param.get("date"));
		log.debug("map={}",map);
		List<Map<String, Object>> chartValue = accountBookService.chartValue(map);
		log.debug("chartValue={}", chartValue);

		return chartValue;
	}

	// detailChart
	@ResponseBody
	@PostMapping(value = "/detailMonthlyChart.do", produces = "application/json; charset=UTF-8")
	public List<Map<String, Object>> detailMonthlyChart(@AuthenticationPrincipal Member member, String date, Model model) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", member.getId());
		map.put("date", date);
		List<Map<String, Object>> list = accountBookService.detailMonthlyChart(map);
		log.debug("list={}", list);
		return list;
	}

	// categoryChart
	@ResponseBody
	@PostMapping(value = "/categoryChart.do", produces = "application/json; charset=UTF-8")
	public List<Map<String, Object>> categoryChart(@RequestParam(defaultValue = "0") int monthly,
			@AuthenticationPrincipal Member member, @RequestBody Map<String, Object> param, String date, Model model) {
		Map<String, Object> map = new HashMap<>();
		map.put("monthly", monthly);
		map.put("id", member.getId());
		map.put("date", date);
		map.put("incomeExpense", param.get("incomeExpense"));

		List<Map<String, Object>> list = accountBookService.categoryChart(map);
		log.debug("list={}", list);

		model.addAttribute("list", list);
		return list;
	}

	// 엑셀
	@GetMapping("/excel")
	public void downloadExcel(HttpServletResponse resp, @AuthenticationPrincipal Member member,
			@RequestParam String startDate, String endDate) throws IOException {
		Map<String, Object> map = new HashMap<>();
		// 엑셀에 담을 리스트 조회
		String id = member.getId();
		map.put("id", id);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		List<AccountBook> list = accountBookService.downloadExcel(map);
		log.debug("list={}", list);

		// 엑셀 파일 생성
		Workbook workbook = new XSSFWorkbook();
		// 엑셀 제목
		String fileName = "나다움-" + member.getName() + "님의 가계부 내역";
		// 엑셀 내부의 시트 생성
		Sheet sheet = workbook.createSheet("나다움-" + member.getName() + "님의 가계부 내역");
		// rowNum 카운팅 변수
		int rowNo = 0;

		// 엑셀 헤더 컬러/폰트
		CellStyle headStyle = workbook.createCellStyle();
		headStyle.setFillForegroundColor(HSSFColor.HSSFColorPredefined.LIGHT_BLUE.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		Font font = workbook.createFont();
		font.setColor(HSSFColor.HSSFColorPredefined.WHITE.getIndex());
		font.setFontHeightInPoints((short) 13);
		headStyle.setFont(font);

		// 헤더 내용
		Row headerRow = sheet.createRow(rowNo++);
		headerRow.createCell(0).setCellValue("날짜");
		headerRow.createCell(1).setCellValue("결제수단");
		headerRow.createCell(2).setCellValue("대분류");
		headerRow.createCell(3).setCellValue("소분류");
		headerRow.createCell(4).setCellValue("내역");
		headerRow.createCell(5).setCellValue("금액");

		// 헤더에 스타일 입히기
		for (int i = 0; i <= 5; i++) {
			headerRow.getCell(i).setCellStyle(headStyle);
		}

		// 엑셀에 담을 내용 포맷 변환용 코드
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		DecimalFormat df = new DecimalFormat("#,###");

		// 엑셀에 담을 리스트 for문으로 한 줄씩 담아주기
		for (AccountBook accountbook : list) {
			Row row = sheet.createRow(rowNo++);
			row.createCell(0).setCellValue(format.format(accountbook.getRegDate()));
			if (accountbook.getPayment() == null) {
				row.createCell(1).setCellValue("미입력");
			} else {
				row.createCell(1).setCellValue(accountbook.getPayment().equals("card") ? "카드" : "현금");
			}
			row.createCell(2).setCellValue(accountbook.getIncomeExpense().equals("I") ? "수입" : "지출");
			row.createCell(3).setCellValue(accountbook.getCategory());
			row.createCell(4).setCellValue(accountbook.getDetail());
			row.createCell(5).setCellValue(df.format(accountbook.getPrice()));
		}

		// 셀 크기 설정
		sheet.setColumnWidth(0, 3000);
		sheet.setColumnWidth(1, 3000);
		sheet.setColumnWidth(2, 2000);
		sheet.setColumnWidth(3, 3000);
		sheet.setColumnWidth(4, 8000);
		sheet.setColumnWidth(5, 3000);

		// 타입 지정
		resp.setContentType("application/vnd.ms-excel");
		// 파일 저장명 -> 이게 지금 안 먹음 ㅠㅠ
		resp.setHeader("content-Disposition", "attachment; filename=" + fileName);

		try {
			workbook.write(resp.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	// 메인 위젯 ajax
	@ResponseBody
	@GetMapping("/widget")
	public Map<String, Object> accountWidget(String date, @AuthenticationPrincipal Member member) {
		Map<String, Object> map = new HashMap<>();
		String id = member.getId();
		map.put("id", id);
		map.put("date", date);
		
		List<Map<String, Object>> incomeList = accountBookService.monthlyTotalIncome(map);
		log.debug("incomeList={}", incomeList);

		// 필요한 값만 맵 객체로 변환
		Map<String, Object> incomeExpenseList = new HashMap<>();

		if (incomeList.size() == 0) {
			incomeExpenseList.put("income", 0);
			incomeExpenseList.put("expense", 0);
		} else if (incomeList.size() == 1) {
			if ((incomeList.get(0).get("incomeExpense")).equals("I")) {
				incomeExpenseList.put("income", incomeList.get(0).get("total"));
				incomeExpenseList.put("expense", 0);
			} else {
				incomeExpenseList.put("income", 0);
				incomeExpenseList.put("expense", incomeList.get(0).get("total"));
			}
		} else {
			incomeExpenseList.put("income", incomeList.get(1).get("total"));
			incomeExpenseList.put("expense", incomeList.get(0).get("total"));
		}

		return incomeExpenseList;
	}

}
