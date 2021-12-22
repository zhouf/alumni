package com.jufeng.util.filter;

//import java.io.UnsupportedEncodingException;

public class StringFilter {
	
	/**
	 * 将从页面上获取的字符转换为可以写入数据库的数据格式
	 * @param inStr
	 * @return
	 */
	public static String cover2DB(String inStr){
		String retStr = null;
		inStr = (inStr==null? "" : inStr.trim());
		/*
		try {
			retStr = new String(inStr.getBytes("gb2312"),"iso8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		/*/
		retStr = inStr;
		//*/
		return retStr;
	}
	
	/**
	 * 从数据库里读取出来的数据,转换为可以在页面上显示的字符
	 * @param inStr
	 * @return
	 */
	public static String cover2html(String inStr){
		String retStr = null;
		inStr = (inStr==null? "" : inStr.trim());
		/*
		try {
			retStr = new String(inStr.getBytes("iso8859-1"),"gb2312");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		/*/
		retStr = inStr;
		//*/
		return retStr;
	}
	
	public static String cover2htmlBlank(String inStr){
		String retStr = "";
		retStr = StringFilter.cover2html(inStr);
		if(retStr.length()==0){
			retStr = "&nbsp;";
		}
		return retStr;
	}
	
	/**
	 * 将字符串截断为页面显示的标题
	 * @param title 传入的待处理字符
	 * @return 返回截断后的字符，如果有截断，则被替换为HTML省略号
	 */
	public static String dealShortTitle(String title){
		String retVal = "";
		int limitTitleLength = 12;
		retVal = (title.length()>=limitTitleLength? title.substring(0,limitTitleLength).concat("&hellip;"):title);
		return retVal;
	}
	
	/**
	 * 将文档内容字符串截断为可以在首页上显示的长度
	 * @param content 传入的待处理字符
	 * @return 返回截断后的字符，如果有截断，则被替换为HTML省略号
	 */
	public static String dealShortContent(String content){
		String retVal = "";
		int limitContentLength = 50;
		retVal = (content.length()>=limitContentLength? content.substring(0,limitContentLength).concat("&hellip;"):content);
		retVal = retVal.replaceAll(" ", "").replaceAll("　", "");
		return retVal;
	}

}
