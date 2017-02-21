package com.example.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.commons.PagingManager;
import com.example.domain.Board;
import com.example.service.BoardService;

@Controller
public class BoardController {
	
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	BoardService boardService;
	
	@GetMapping(value = { "/", "/board" })
	public ModelAndView selectList(Integer start) {
		if (start == null || start < 0) {
			start = 0;
		}
		int totalRecord = boardService.selectTotalRecord();
		int pageSize = 10;

		List<Board> boardList = boardService.selectList(start, pageSize);
		PagingManager pagingManager = new PagingManager(start, totalRecord, pageSize);

		ModelAndView mav = new ModelAndView("list");
		mav.addObject("boardList", boardList);
		mav.addObject("pagingManager", pagingManager);
		
		return mav;
	}
	
	@GetMapping("/board/writeForm")
	public String writeForm() {
		return "write";
	}

	@GetMapping("/board/{board_pk}")
	public ModelAndView selectOne(@PathVariable int board_pk) {
		Board board = boardService.selectOne(board_pk);
		ModelAndView mav = new ModelAndView("detail");
		mav.addObject("board", board);

		return mav;
	}

	@PostMapping("/board")
	public String insert(Board board) {
		boardService.insert(board);
		return "redirect:/board/"+board.getBoard_pk();
	}

	@DeleteMapping("/board/{board_pk}")
	@ResponseBody
	public String delete(@PathVariable int board_pk) {
		boardService.delete(board_pk);
		
		return "{}";
	}

	@PatchMapping("/board")
	@ResponseBody
	public String update(@RequestBody Board board) {
		boardService.update(board);
		
		return "{}";
	}
}