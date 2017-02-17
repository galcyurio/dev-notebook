package com.sds.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sds.domain.Member;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	@ResponseBody
	@RequestMapping("regist.do")
	public Member regist(@RequestBody Member member) {
		System.out.println(member.toString());
		
		return member;
	}
}
