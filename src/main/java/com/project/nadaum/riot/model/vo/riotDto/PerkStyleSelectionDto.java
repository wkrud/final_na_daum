package com.project.nadaum.riot.model.vo.riotDto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class PerkStyleSelectionDto implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	private int perk;
	private int var1;
	private int var2;
	private int var3;



}
