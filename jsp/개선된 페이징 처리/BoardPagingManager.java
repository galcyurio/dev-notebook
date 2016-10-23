package com.sds.commons;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.sds.board.domain.Board;

public class BoardPagingManager {
	private HttpServletRequest request;

	private int start;
	private int currentPage;
	private int totalRecord;
	private int pageSize;
	private int blockSize;

	private int totalPage;
	private int firstPage;
	private int lastPage;

	private int curPos;
	private int firstRecord;

	private List<Board> boardList;

	public BoardPagingManager(HttpServletRequest request) {
		this.request = request;

		Map<String, Object> model = (Map) request.getAttribute("model");

		setBoardList((List) model.get("boardList"));

		start = 0;

		if (request.getParameter("start") != null) {
			start = Integer.parseInt(request.getParameter("start"));
		}

		totalRecord = (Integer) model.get("totalRecord");
		pageSize = (Integer) model.get("pageSize");
		blockSize = 10;
		
		if (start <= 0) {
			start = 0;
		} else if (start >= totalRecord) {
			start = totalRecord-pageSize;
		}

		currentPage = (int) Math.ceil((float) start / pageSize) + 1;

		totalPage = (int) Math.ceil((float) totalRecord / pageSize);
		firstPage = currentPage - (currentPage - 1) % blockSize;
		lastPage = firstPage + blockSize - 1;

		if (lastPage >= totalPage) {
			lastPage = totalPage;
		}

		curPos = (currentPage - 1) * pageSize;
		firstRecord = totalRecord - curPos;

		System.out.println("start = " + start);
		System.out.println("currentPage = " + currentPage);
		System.out.println("totalRecord = " + totalRecord);
		System.out.println("pageSize = " + pageSize);
		System.out.println("blockSize = " + blockSize);

		System.out.println("totalPage = " + totalPage);
		System.out.println("firstPage = " + firstPage);
		System.out.println("lastPage = " + lastPage);

		System.out.println("curPos = " + curPos);
		System.out.println("firstRecord = " + firstRecord);
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getCurPos() {
		return curPos;
	}

	public void setCurPos(int curPos) {
		this.curPos = curPos;
	}

	public int getFirstRecord() {
		return firstRecord;
	}

	public void setFirstRecord(int firstRecord) {
		this.firstRecord = firstRecord;
	}

	public List<Board> getBoardList() {
		return boardList;
	}

	public void setBoardList(List<Board> boardList) {
		this.boardList = boardList;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

}
