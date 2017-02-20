package com.example.commons;

public class PagingManager {
	private int start;
	private int totalRecord;
	private int pageSize;
	private int blockSize = 10;

	private int currentPage;
	private int totalPage;
	private int firstPage;
	private int lastPage;
	private int firstRecord;

	public PagingManager() {
		// empty
	}

	public synchronized PagingManager getPage(int start, int totalRecord) {
		this.start = start;
		this.totalRecord = totalRecord;
		this.pageSize = 10;

		return process();
	}

	public synchronized PagingManager getPage(int start, int totalRecord, int pageSize) {
		this.start = start;
		this.totalRecord = totalRecord;
		this.pageSize = pageSize;

		return process();
	}

	protected PagingManager process() {
		if(start < 0) {
			start = 0;
		} else if(start > totalRecord) {
			start = totalRecord - pageSize;
		}

		currentPage = (int) Math.ceil((float) start / pageSize) + 1;
		totalPage = (int) Math.ceil((float) totalRecord / pageSize);
		firstPage = currentPage - (currentPage - 1) % blockSize;
		lastPage = firstPage + blockSize - 1;

		if(lastPage > totalPage) {
			lastPage = totalPage;
		}

		firstRecord = totalRecord - (currentPage - 1) * pageSize;

		return this;
	}

	@Override
	public String toString() {
		return "PagingManager [start=" + start + ", totalRecord=" + totalRecord + ", pageSize=" + pageSize
				+ ", blockSize=" + blockSize + ", currentPage=" + currentPage + ", totalPage=" + totalPage
				+ ", firstPage=" + firstPage + ", lastPage=" + lastPage + ", firstRecord=" + firstRecord + "]";
	}


	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
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

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
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

	public int getFirstRecord() {
		return firstRecord;
	}

	public void setFirstRecord(int firstRecord) {
		this.firstRecord = firstRecord;
	}

}
