package org.zerock.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class) // JUnit의 기본 클래스 설정  괄호 안은 툴에 따라 다름
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") 
@Log4j // logging(기록) 하기 위한 라이브러리 
public class SampleTests {
	
	@Setter(onMethod_ = { @Autowired}) //의존성 주입하는 코드. 
	private Restaurant restaurant;
	
	@Test
	public void textExist() {
		
		assertNotNull(restaurant); // assertNotNull JUnit에서 제공하는 것 참조변수가 비어있지 않다  null이 아니면 테스트 통과
		// 콘솔창에 내용을 찍기 위한 것  
		log.info(restaurant);
		log.info("--------------------------------");
		log.info(restaurant.getChef());// getChef 게터
	}

}