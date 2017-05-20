package com.jufeng.util;

/**
 * 这是一个对MD5进行再次封装的一个类
 * @author ZhouFeng
 *
 * 2010-8-18
 */
public class PWD {

	/**
	 * 调用MD5算法对输入字符串进行加密处理
	 * @param args
	 */
	public static String encode(String inPwd){
		StringBuffer sb = new StringBuffer((new MD5()).getMD5ofStr(inPwd));
		return sb.toString();
	}
	
	/**
	 * 用主方法做测试
	 */
	public static void main(String[] args) {
		System.out.println("123:" + PWD.encode("123"));
		System.out.println("admin:" + PWD.encode("admin"));
	}
}
