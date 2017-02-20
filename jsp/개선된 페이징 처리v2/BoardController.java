package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.commons.PagingManager;
import com.example.service.BoardService;
import com.example.vo.Board;

@Controller
@RequestMapping(value = "/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	// 글 목록 보기
	@RequestMapping(value = "/list.do")
	public ModelAndView selectList(Integer start) {
		if (start == null || start < 0) {
			start = 0;
		}
		
		PagingManager pagingManager = new PagingManager().getPage(start, boardService.selectTotalRecord());
		List<Board> boardList = boardService.selectList(start, 10);

		ModelAndView mav = new ModelAndView("board/list");
		mav.addObject("boardList", boardList);
		mav.addObject("pagingManager", pagingManager);

		return mav;
	}

	// 글 1건 조회
	@RequestMapping(value = "/detail.do")
	public ModelAndView selectOne(int board_pk) {
		Board board = boardService.selectOne(board_pk);

		ModelAndView mav = new ModelAndView("board/detail");
		mav.addObject("board", board);

		return mav;
	}

	// 글 업데이트
	@RequestMapping(value = "/update.do")
	public ModelAndView update(Board board) {
		int result = boardService.update(board);

		ModelAndView mav = new ModelAndView("board/detail");
		mav.addObject("board", board);

		return mav;
	}

	// 글 삭제
	@RequestMapping(value = "/delete.do")
	public String delete(int board_pk) {
		int result = boardService.delete(board_pk);

		return "redirect:/board/list.do";
	}

	// 글쓰기 양식
	@RequestMapping(value = "/write.do")
	public String writeForm() {
		return "board/write";
	}

	// 글쓰기
	@RequestMapping(value = "/insert.do")
	public String insert(Board board) {
		int result = boardService.insert(board);

		return "redirect:/board/list.do";
	}
}
