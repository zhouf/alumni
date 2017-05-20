package com.jufeng.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.sql.rowset.WebRowSet;

import org.apache.log4j.Logger;

import com.jufeng.util.filter.StringFilter;
import com.sun.rowset.WebRowSetImpl;

public class DBManage {
	static Logger log = Logger.getLogger(DBManage.class.getName());
	static int connCount = 0;

	/**
	 * 返回一个连接对象
	 * 
	 * @return
	 */
	public static Connection getConnection() {
		Connection conn = null;
		try {
		
			//获取数据库连接配置
			DBConfig dbconf = new DBConfig();
			
			//根据连接配置获取数据库连接
			Class.forName(dbconf.getDriver()).newInstance();
			conn= DriverManager.getConnection(dbconf.getUrl(),dbconf.getUserName(),dbconf.getPassword());
			
		} catch (Exception ex) {
			log.error("出现例外，信息是:" + ex.getMessage());
			ex.printStackTrace();
		}
		connCount++;
		log.info("getConnection(" + connCount + ") Conn:" + conn.toString());
		return conn;
	}

	/**
	 * 在此处进行关闭连接的操作
	 */
	public static void closeConnection(Connection conn) {
		try {
			if (conn != null && conn.isClosed() == false) {
				conn.close();
			}
		} catch (SQLException ex) {
			log.error("出现例外，信息是:" + ex.getMessage());
			ex.printStackTrace();
		} finally {
			try {
				if (conn != null && conn.isClosed() == false) {
					conn.close();
				}
			} catch (SQLException e) {
				log.error("关闭conn时出现异常:" + e.toString());
				e.printStackTrace();
			}
			connCount--;
			log.info("Close Conn(" + connCount + "):" + conn.toString());
		}
	}

	/**
	 * 返回一个WebRowSet结果集
	 * 
	 * @param sql
	 *            传入SQL语句
	 * @return 返回通过SQL查询的结果集
	 */
	public static WebRowSet getWRS(String sql) {
		Connection conn = DBManage.getConnection();
		WebRowSet wrs = getWRS(conn, sql);
		DBManage.closeConnection(conn);
		return wrs;
	}

	/**
	 * 这是一个需要传入连接对象的方法,执行完成后不关闭连接对象
	 * 
	 * @param conn
	 * @param sql
	 * @return
	 */
	public static WebRowSet getWRS(Connection conn, String sql) {
		log.debug("getWRS(conn,sql)" + conn.toString());
		WebRowSet wrs = null;
		try {
			ResultSet rs = conn.createStatement().executeQuery(StringFilter.cover2DB(sql));
			wrs = new WebRowSetImpl();
			wrs.populate(rs);
			rs.close();
		} catch (SQLException e) {
			log.error("get WRS error:" + e.toString());
			e.printStackTrace();
		}
		return wrs;
	}

	/**
	 * 返回一个查询的结果,只对一行一列的数据有效
	 * 
	 * @param sql
	 *            输入的SQL语句
	 * @return 返回该SQL语句查询的结果
	 */
	public static String changeID(String sql) {
		String retStr = "";
		WebRowSet rs = DBManage.getWRS(sql);
		try {
			if (rs.next()) {
				retStr = rs.getString(1);
			}
			rs.close();
		} catch (SQLException e) {
			log.error("执行changeID时出现异常:" + e.toString());
			e.printStackTrace();
		}
		return retStr;
	}

	/**
	 * 这是一个需要连接对象的封装
	 * 
	 * @param conn
	 * @param sql
	 * @return
	 */
	public static String changeID(Connection conn, String sql) {
		log.info("changeID(conn,sql)" + conn.toString());
		String retStr = "";
		WebRowSet rs = DBManage.getWRS(conn, sql);
		try {
			if (rs.next()) {
				retStr = rs.getString(1);
			}
			rs.close();
		} catch (SQLException e) {
			log.error("执行changeID时出现异常:" + e.toString());
			e.printStackTrace();
		}
		return retStr;
	}

	/**
	 * 返回一个查询的结果,只对一行一列的数据有效
	 * 
	 * @param sql
	 *            输入的SQL语句
	 * @return 返回该SQL语句查询的结果
	 */
	public static int getCount(String sql) {
		int retVal = 0;
		WebRowSet rs = DBManage.getWRS(sql);
		try {
			if (rs.next()) {
				retVal = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			log.error("执行changeID时出现异常:" + e.toString());
			e.printStackTrace();
		}
		return retVal;
	}

	/**
	 * 这是一个需要连接对象的封装
	 * 
	 * @param conn
	 * @param sql
	 * @return
	 */
	public static int getCount(Connection conn, String sql) {
		log.info("getCount(conn,sql)" + conn.toString());
		int retVal = 0;
		WebRowSet rs = DBManage.getWRS(conn, sql);
		try {
			if (rs.next()) {
				retVal = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			log.error("执行changeID时出现异常:" + e.toString());
			e.printStackTrace();
		}
		return retVal;
	}

	/**
	 * 这是一个SQL语句的方法
	 * 
	 * @param sql
	 * @return
	 */
	public static int doUpdate(String sql) {
		int retVal = 0;
		sql = StringFilter.cover2DB(sql);
		Connection conn = DBManage.getConnection();
		retVal = doUpdate(conn, sql);
		closeConnection(conn);
		return retVal;
	}

	/**
	 * 这是一个需要连接对象的方法
	 * 
	 * @param conn
	 * @param sql
	 * @return
	 */
	public static int doUpdate(Connection conn, String sql) {
		log.info("doUpdate(conn,sql)" + conn.toString());
		int retVal = 0;
		sql = StringFilter.cover2DB(sql);
		try {
			retVal = conn.createStatement().executeUpdate(sql);
		} catch (SQLException e) {
			log.error("执行doUpdate()时出现异常");
		}
		return retVal;
	}

}
