package com.jufeng.util.page;

import java.sql.SQLException;

import javax.sql.rowset.WebRowSet;

import org.apache.log4j.Logger;

/**
 * 这是一个处理分页的类
 * @author Administrator
 *
 */
public class Pager {
	static Logger log = Logger.getLogger(Pager.class.getName());
	private int currentPage;
	private int pageItem;
	private int allRow;
	private WebRowSet wrs;
	

	public int getCurrentPage() {
		return (currentPage==0? 1 : currentPage);
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageItem() {
		return pageItem;
	}
	public void setPageItem(int pageItem) {
		this.pageItem = pageItem;
	}
	public int getAllRow() {
		return allRow;
	}
	public void setAllRow(int allRow) {
		this.allRow = allRow;
	}
	
	/**
	 * 返回一个结果集
	 * @return
	 */
	public WebRowSet getWrs() {
		try {
			if(this.getCurrentPage()==1){
				log.info("第一页 beforeFirst()");
				wrs.beforeFirst();
			}else{
				log.info("第"+this.getCurrentPage()+"页,跳到" + this.getPageItem()*(this.getCurrentPage()-1));
				wrs.absolute(this.getPageItem()*(this.getCurrentPage()-1));
			}
		} catch (SQLException e) {
			log.error("移动记录的指针出现异常:" + e.toString());
			e.printStackTrace();
		}
		return wrs;
	}
	
	/**
	 * 设备要处理的结果集,还要获取结果集的记录条数
	 * @param wrs
	 */
	public void setWrs(WebRowSet wrs) {
		this.wrs = wrs;
		try {
			wrs.last();
			this.setAllRow(wrs.getRow());
		} catch (SQLException e) {
			log.error("获取结果集记录数出现异常:" + e.toString());
			e.printStackTrace();
		}
		log.info("结果集的记录条数为:" + this.getAllRow());
	}
	
	
	/**
	 * 获得[首页]按钮的HTML
	 * @return
	 */
	public String firstPage(){
		return "<input type=\"button\" value=\"首页\" onClick=\"goPage(1)\">";
	}
	
	/**
	 * 获得［首页］文字的HTML
	 * @return
	 */
	public String firstPageText(){
		return "<span style=\"cursor:hand\" onClick=\"goPage(1)\">首页</span>";
	}

	/**
	 * 获得[下一页]按钮的HTML
	 * @return
	 */
	public String nextPage(){
		String retStr = "";
		retStr = "<input type=\"button\" value=\"下一页\" onClick=\"goPage("+(this.getCurrentPage()+1)+")\" ";
		if(this.getCurrentPage()==this.getLastPage()){
			//如果是最后一页,则下一页为不可用
			retStr += " disabled ";
		}
		retStr += ">";
		return retStr;
	}

	/**
	 * 获得[下一页]文本的HTML
	 * @return
	 */
	public String nextPageText(){
		String retStr = "";
		if(this.getCurrentPage()==this.getLastPage()){
			//如果是最后一页,则下一页为不可用
			retStr = "<div>下一页</div>";
		}else{
			retStr = "<div style=\"cursor:hand\" onClick=\"goPage("+(this.getCurrentPage()+1)+")\">下一页</div>";
		}
		return retStr;
	}

	/**
	 * 获得[上一页]按钮的HTML
	 * @return
	 */
	public String forwardPage(){
		String retStr = "";
		retStr = "<input type=\"button\" value=\"上一页\" onClick=\"goPage("+(this.getCurrentPage()-1)+")\" ";
		if(this.getCurrentPage()==1){
			//如果是第一页,则上一页为不可用
			retStr += " disabled ";
		}
		retStr += ">";
		return retStr;
	}
	
	/**
	 * 获得[上一页]文本的HTML
	 * @return
	 */
	public String forwardPageText(){
		String retStr = "";
		if(this.getCurrentPage()==1){
			//如果是第一页,则上一页为不可用
			retStr = "<div>上一页</div>";
		}else{
			retStr = "<div style=\"cursor:hand\" onClick=\"goPage("+(this.getCurrentPage()-1)+")\">上一页</div>";
		}
		return retStr;
	}
	
	/**
	 * 获得[尾页]按钮的HTML
	 * @return
	 */
	public String lastPage(){
		return "<input type=\"button\" value=\"尾页\" onClick=\"goPage("+this.getLastPage()+")\">";
	}
	
	/**
	 * 获得［尾页］文本的HTML
	 * @return
	 */
	public String lastPageText(){
		return "<div style=\"cursor:hand\" onClick=\"goPage("+this.getLastPage()+")\">尾页</div>";
	}
	
	/**
	 * 返回当前的结果集状态,第?/?页,共??条记录
	 * @return
	 */
	public String getState(){
		String retStr = "";
		retStr = "第"+this.getCurrentPage()+"/"+this.getLastPage()+"页 共有"+this.getAllRow()+"条记录";
		retStr += "<input type=\"hidden\" name=\"currentPage\">";
		return retStr;
	}
	
	/**
	 * 获取最后一页的页数
	 * @return
	 */
	private int getLastPage(){
		int last = 0;
		if(this.getAllRow()%this.getPageItem()==0){
			last = this.getAllRow()/this.getPageItem();
		}else{
			last = this.getAllRow()/this.getPageItem() + 1;
		}
		return last;
	}	
}
