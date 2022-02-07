package com.project.nadaum.accountbook.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AccountBookChart implements Serializable {

   private static final long serialVersionUID = 1L;

   private String category;
   private int total;
}
