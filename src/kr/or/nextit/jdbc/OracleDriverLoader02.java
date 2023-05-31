package kr.or.nextit.jdbc;

import javax.servlet.http.HttpServlet;

import org.apache.commons.dbcp2.ConnectionFactory;
import org.apache.commons.dbcp2.PoolableConnectionFactory;

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
			String userName = "jsp";
			String pw = "oracle";

			ConnectionFactory connFactory = 
					new DriverManagerConnection(jdbcUrl, userName, pw);
		
			PoolableConnectionFactory poolableConnFactory =
					new PoolableConnectionFactory(connFactory, null);
			poolableConnFactory.setValidationQuery("select 1 from dual");
			
		}catch(Exception e) {
			
		}
		
	}
	
}
