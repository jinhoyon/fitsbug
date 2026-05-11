package util;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisSqlSessionFactory {
	/* xml에 있는 쿼리문을 가져다 사용할 수 있게 해주는 역할! */
	private static SqlSessionFactory sqlSessionFactory;
	
	static {
		try {
			String resource = "resource/mybatis-config.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			
			//SqlSessionFactoryBuilder 생성
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			
			//SqlSessionFactory 생성
			sqlSessionFactory = builder.build(inputStream);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory; 
	}
}