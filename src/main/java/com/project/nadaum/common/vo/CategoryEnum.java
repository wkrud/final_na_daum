package com.project.nadaum.common.vo;

public enum CategoryEnum {
	
	공지사항("an"), 친구("fr"), 친구요청("rf"), 다이어리("dy"), 가계부("ab")
	,문화("cu"), 오디오북("au"), 게임("lol"), 캘린더("ca"), 피드("fe");
	private String category;
	
	CategoryEnum(String category) {
		this.category = category;
	}
	
	public static CategoryEnum _valueOf(String category) {
		switch(category) {
		case "an": return 공지사항;
		case "fr": return 친구;
		case "rf": return 친구요청;
		case "dy": return 다이어리;
		case "ab": return 가계부;
		case "cu": return 문화;
		case "au": return 오디오북;
		case "lol": return 게임;
		case "ca": return 캘린더;
		case "fe": return 피드;		
		default: throw new AssertionError("Unknow Type Error: " + category);
		}
	}

}
