package kr.or.nextit.jdbc;

import java.sql.DriverManager;

import javax.servlet.http.HttpServlet;

import org.apache.commons.dbcp2.ConnectionFactory;
import org.apache.commons.dbcp2.DriverManagerConnectionFactory;
import org.apache.commons.dbcp2.PoolableConnection;
import org.apache.commons.dbcp2.PoolableConnectionFactory;
import org.apache.commons.dbcp2.PoolingDriver;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;

public class OracleDriverLoader02 extends HttpServlet{

	public void init() {
		loadJDBCDriver();
		initConnectionPool();
	}

	private void loadJDBCDriver() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("공지 : 드라이버 로딩 굿");			
		}catch(Exception e) {
			System.out.println("공지 : 드라이버 로딩 실패");
			e.printStackTrace();
		}
	}
	
	private void initConnectionPool() {
		try {
			String jdbcUrl = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
			String userName = "jsp2";
			String pw = "oracle";

			ConnectionFactory connFactory = 
					new DriverManagerConnectionFactory(jdbcUrl, userName, pw);
		
			PoolableConnectionFactory poolableConnFactory =
					new PoolableConnectionFactory(connFactory, null);
			poolableConnFactory.setValidationQuery("select 1 from dual");
			
			GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig();
			poolConfig.setTimeBetweenEvictionRunsMillis(1000L * 60L * 10L);
			poolConfig.setTestWhileIdle(true);
			poolConfig.setMinIdle(4);
			poolConfig.setMaxTotal(10);
			
			GenericObjectPool<PoolableConnection> connectionPool =
					new GenericObjectPool<>(poolableConnFactory, poolConfig);
			
			Class.forName("org.apache.commons.dbcp2.PoolingDriver");
			PoolingDriver driver = 
					(PoolingDriver) DriverManager.getDriver("jdbc:apache:commons:dbcp:");
			
			driver.registerPool("study", connectionPool);
			System.out.println("공지 : DBCP 로드 성공 ");
		}catch(Exception e) {
			System.out.println("공지 : ConnectionPool 로드 실패 ");
			e.printStackTrace();
		}
		
	}
	
}
