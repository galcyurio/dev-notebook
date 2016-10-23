package com.sds.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.sds.board.dao.BoardDAO;
import com.sds.board.domain.Board;

public class ListController implements Controller {
	BoardDAO boardDAO;

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 3. 비즈니스 로직 실시
		int totalRecord = boardDAO.selectCount();
		
		String start_temp = request.getParameter("start");
		String pageSize_temp = request.getParameter("pageSize");
		
		int start = 0;
		int pageSize = 10;
		
		if(start_temp != null){
			start = Integer.parseInt(start_temp);
		} if (pageSize_temp != null) {
			pageSize = Integer.parseInt(pageSize_temp);
		}
		
		List<Board> boardList = boardDAO.selectByPage(start, pageSize);

		// 4. 결과 저장
		Map<String, Object> model = new HashMap<>();
		model.put("boardList", boardList);
		model.put("totalRecord", totalRecord);
		model.put("pageSize", pageSize);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("model", model);
		
		// 5. 뷰페이지 보여주기
		mav.setViewName("board/list");

		return mav;
	}

	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}

}
