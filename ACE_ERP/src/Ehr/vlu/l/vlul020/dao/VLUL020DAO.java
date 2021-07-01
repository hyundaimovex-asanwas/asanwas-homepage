package Ehr.vlu.l.vlul020.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class VLUL020DAO extends AbstractDAO {

	public VLUL020DAO(String p_dsId, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	public void VLUL020_SHR(CBox p_box) throws CException {  //본사

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_SHR");

	    String GBN_CD  = p_box.get("GUBUN");

		StringBuffer sb = new StringBuffer();

	    if ( GBN_CD.equals("1")|| GBN_CD.equals("4") ) {
			 sb.append("AND A.PAYGRD NOT IN ('300','700','890')");
	     } else if ( GBN_CD.equals("2") ) {
	    	 sb.append("AND A.PAYGRD IN ('300','700','890')");
	     } else {
	    	 sb.append("AND 2=2");
	     }
	    
	    StringBuffer sb2 = new StringBuffer();
	    
	     if ( GBN_CD.equals("1") ) {  // 정규직
	    	 sb2.append("AND A.JOBREF!='8'");
	     } else if ( GBN_CD.equals("4") ) { //PJT
	    	 sb2.append("AND A.JOBREF='8'");
	     } else {
	    	 sb2.append("AND 2=2");
	     }

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb2.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
				p_box.get("EMPNOH"),                       							// 고과자
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 피고과자
		};
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR2",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	public void VLUL020_SHR_01(CBox p_box) throws CException { // //본사외

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_SHR_01");


	    String GBN_CD  = p_box.get("GUBUN");

		StringBuffer sb = new StringBuffer();

	    if ( GBN_CD.equals("1")||GBN_CD.equals("4") ) {
			 sb.append("AND A.PAYGRD NOT IN ('300','700','890')");
	     } else if ( GBN_CD.equals("2") ) {
	    	 sb.append("AND A.PAYGRD IN ('300','700','890')");
	     } else {
	    	 sb.append("AND 2=2");
	     }
	    
	     StringBuffer sb2 = new StringBuffer();
	    
	     if ( GBN_CD.equals("1") ) {  // 정규직
	    	 sb2.append("AND A.JOBREF!='8'");
	     } else if ( GBN_CD.equals("4") ) { //PJT
	    	 sb2.append("AND A.JOBREF='8'");
	     } else {
	    	 sb2.append("AND 2=2");
	     }

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb2.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
				p_box.get("EMPNOH"),                       							// 피고과자
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
		};

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.1, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR2",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUL020_SHR_02(CBox p_box) throws CException {
		/** 부서장 본사 조회 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_SHR_02");

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
				p_box.get("EMPNOH"),                       							// 피고과자
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
		};

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.1, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUL020_SHR_03(CBox p_box) throws CException {
		/** 부서장 본사외 조회 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_SHR_03");

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
				p_box.get("EMPNOH"),                       							// 피고과자
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
		};

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.1, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR2",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUL020_SHR_ITEM(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_SHR_ITEM");

		//System.out.println(p_box);


		String gun_cd;
	    String PAYGRD  = p_box.get("JOB_CD");

	    if ( PAYGRD.equals("140")||PAYGRD.equals("150")||PAYGRD.equals("160")||PAYGRD.equals("170")) {
	    	 gun_cd = "2";
	     } else if (PAYGRD.equals("180")||PAYGRD.equals("190")) {
	    	 gun_cd = "4";
	     } else if (PAYGRD.equals("200")||PAYGRD.equals("210")) {
	    	 gun_cd = "5";
	     } else if (PAYGRD.equals("220")||PAYGRD.equals("230")) {
	    	 gun_cd = "6";
	     } else if (PAYGRD.equals("240")||PAYGRD.equals("250")) {
	    	 gun_cd = "7";
	     } else if (PAYGRD.equals("260")||PAYGRD.equals("270")) {
	    	 gun_cd = "8";
	     } else {
	    	 gun_cd = "9";
	     }

		Object[] bind = new Object[] {

				p_box.get("ENOH_NO"),                       							// 고과자
				p_box.get("ENO_NO"),                       							// 피고과자
				p_box.get("EVASEQ"),                       							// 차수
//				gun_cd,                       												// 직급
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                     // 고과년월
				p_box.get("ENO_NO"),   												// 피고과자
//				p_box.get("HEAD_CD"),                       							// 본부
//				gun_cd,                       												// 직급

		};
		prop.add("SCORE",  prop.COLUMN_TYPE_DECIMAL, 3.1, prop.CONSTRAINT_TB_NORMAL);
		prop.add("CH_SCORE",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("CH_SCORE2",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR",  prop.COLUMN_TYPE_DECIMAL, 3.1, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR2",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}


	public void VLUL020_SHR_ITEM_01(CBox p_box) throws CException { //부서장
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_SHR_ITEM_01");

		//System.out.println(p_box);

		Object[] bind = new Object[] {

				p_box.get("ENOH_NO"),                       							// 고과자
				p_box.get("ENO_NO"),                       							// 피고과자
				p_box.get("EVASEQ"),                       							// 차수
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                    // 고과월

		};
		prop.add("DPT_CH_SCR",  prop.COLUMN_TYPE_DECIMAL, 2.3, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}





	public void VLUL020_SAV(GauceValueObject vo, CBox p_box) throws CException {  //정규계약 저장

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_SAV");

		//System.out.println(p_box);
		//System.out.println(vo);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVAYM" ))
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("SEQ2" ))
		        ,JSPUtil.rns(vo.get("DPT_IMPORT" ))
		        ,JSPUtil.rns(vo.get("SCR" ))
		        ,JSPUtil.rns(vo.get("SCRGBN" ))
		        ,JSPUtil.rns(vo.get("DPT_CH_SCR" ))
		        ,JSPUtil.rns(vo.get("HEAD_CD" ))
		        ,JSPUtil.rns(vo.get("DPT_CD" ))
		        ,JSPUtil.rns(vo.get("TEAM_CD" ))
		        ,JSPUtil.rns(vo.get("JOB_CD" ))
		        ,JSPUtil.rns(vo.get("FEEDBACK" ))
		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}


	public void VLUL020_SAV_01(GauceValueObject vo, CBox p_box) throws CException { //부서장 저장

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_SAV_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                     							//
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("SEQ2" ))
		        ,JSPUtil.rns(vo.get("DPT_IMPORT" ))
		        ,JSPUtil.rns(vo.get("SCR" ))
		        ,JSPUtil.rns(vo.get("SCRGBN" ))
		        ,JSPUtil.rns(vo.get("DPT_CH_SCR" ))

		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}

	public void VLUL020_SAV_COR(CBox p_box) throws CException {  //보정

	    String sql = "{ call PKG_XF_VLUL020_INS.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}

	public void VLUL020_SAV_COR_01(CBox p_box) throws CException {  //계약 보정

	    String sql = "{ call PKG_XF_VLUL020_CON.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}

	public void VLUL020_SAV_COR_02(CBox p_box) throws CException {  //부서장 보정

	    String sql = "{ call PKG_XF_VLUL020_DPT.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}
	
	public void VLUL020_SAV_COR_PJT(CBox p_box) throws CException {  //PJT 보정

	    String sql = "{ call PKG_XF_VLUL020_PJT.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}

	public void VLUL020_UPT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_UPT");
		
		//String Evaseq = JSPUtil.rns(vo.get("EVASEQ"));
		String Evaseq = p_box.get("EVASEQ");		
		
		String dblSCR = p_box.get("TOTAL_SCR");

		/** 조회 조건(사용일자)에 따른 처리 **/
		StringBuffer sb = new StringBuffer();
		if (Evaseq.equals("1")) {
			sb.append("SCR1= '"+dblSCR+"'");
		} else if (Evaseq.equals("2")) {
			sb.append("SCR2= '"+dblSCR+"'");
		} else if (Evaseq.equals("3")) {
			sb.append("SCR3= '"+dblSCR+"'");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				

				p_box.get("REG_YM_SHR").replaceAll("-", ""),                    // 고과월
				p_box.get("EMPNO")                      						// 피고과자
				

		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	public void VLUL020_UPT_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_UPT_01");
		String Evaseq = JSPUtil.rns(vo.get("EVASEQ"));
		String dblSCR = p_box.get("TOTAL_SCR");

		/** 조회 조건(사용일자)에 따른 처리 **/
		StringBuffer sb = new StringBuffer();
		if (Evaseq.equals("1")) {
			sb.append("SCR1= '"+dblSCR+"'");
		} else if (Evaseq.equals("2")) {
			sb.append("SCR2= '"+dblSCR+"'");
		} else if (Evaseq.equals("3")) {
			sb.append("SCR3= '"+dblSCR+"'");
		} else if (Evaseq.equals("4")) {
			sb.append("SCR4= '"+dblSCR+"'");
		} else if (Evaseq.equals("5")) {
			sb.append("SCR5= '"+dblSCR+"'");
		} else if (Evaseq.equals("6")) {
			sb.append("SCR6= '"+dblSCR+"'");
		} else if (Evaseq.equals("7")) {
			sb.append("SCR7= '"+dblSCR+"'");
		} else if (Evaseq.equals("8")) {
			sb.append("SCR8= '"+dblSCR+"'");
		} else if (Evaseq.equals("9")) {
			sb.append("SCR9= '"+dblSCR+"'");
		} else if (Evaseq.equals("10")) {
			sb.append("SCR10= '"+dblSCR+"'");
		} else if (Evaseq.equals("11")) {
			sb.append("SCR11= '"+dblSCR+"'");
		} else if (Evaseq.equals("12")) {
			sb.append("SCR12= '"+dblSCR+"'");
		} else if (Evaseq.equals("13")) {
			sb.append("SCR13= '"+dblSCR+"'");
		} else if (Evaseq.equals("14")) {
			sb.append("SCR14= '"+dblSCR+"'");
		} else if (Evaseq.equals("15")) {
			sb.append("SCR15= '"+dblSCR+"'");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                     							//
			    ,JSPUtil.rns(vo.get("EMPNO" ))
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	public void VLUL020_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVAYM" ))
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("SEQ2" ))
		};
		/** UPDATE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	public void VLUL020_DEL_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL020_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                     							//
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("SEQ2" ))
		};
		/** UPDATE메소드 호출  **/
		deleteProcess(sql, bind);
	}
}
