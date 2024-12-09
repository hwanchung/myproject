package org.zerock.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Setter;

@Component
@Data
public class Restaurant { //레스토랑은 셰프에 의존적이다. 
	// 의존성 삽입관계를 만드는 첫번째 방법. 두번째는 생성자를 이용해서 
	@Setter(onMethod_ = @Autowired) // 주입시켜주는 것이 Setter. lombok에서 제공 Autowired가 주입하라는 명령어
	private Chef chef; //프로퍼티가 있음. 이제 의존성 관계가 됨

}
