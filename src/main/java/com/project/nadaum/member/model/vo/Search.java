package com.project.nadaum.member.model.vo;

public enum Search {
	
	T("true"), F("false");
	
	private String value;
	
	Search(String value){
		this.value = value;
	}
	
	public static Search _valueOf(String value) {
		switch(value) {
		case "true": return T;
		case "false": return F;
		default: throw new AssertionError("Unknown Type Error : " + value);
		}
	}

}
