package com.jufeng.database;

/**
 * 这是一个获取数据库配置的类
 * @author ZhouFeng
 */

public class DBConfig {
	private String url;
	private String driver;
	private String userName;
	private String password;

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		//DBConfig conf = new DBConfig();
	}
	
	/**
	 * 在构造函数里初始化连接参数
	 */
	public DBConfig(){
		this.setDriver("org.hsqldb.jdbcDriver");
		this.setUrl("jdbc:hsqldb:hsql://localhost/alumnidb;shutdown=true");
		this.setUserName("sa");
		this.setPassword("");
	}



	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	  
}
