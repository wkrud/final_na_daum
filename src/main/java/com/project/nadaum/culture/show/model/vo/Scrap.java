package com.project.nadaum.culture.show.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Scrap implements Serializable {

   private static final long serialVersionUID = 1L;

   private String code;
   private String id;
   private Date regDate;
   private String apiCode;
}