package Ehr.vlu.k.vluk050.dao;

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

public class VLUK050DAO extends AbstractDAO {

	public VLUK050DAO(String p_dsId, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	public void VLUK050_SHR(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR");

	    String GBN_CD  = p_box.get("GUBUN");

	    StringBuffer sb = new StringBuffer();
	    
	     if ( GBN_CD.equals("1") ) {  // 정규직
	    	 sb.append("AND A.PAYGRD NOT IN ('300','700','890') AND C.OCC_CD != '8'");
	     } else if ( GBN_CD.equals("2") ) { //계약직 + PJT 2020.11.30 수정함
	    	 sb.append("AND A.PAYGRD IN ('300','700','890') ");
	     } else if ( GBN_CD.equals("3") ) { //PJT
	    	 sb.append("AND C.OCC_CD ='8'");
	     } else {
	    	 sb.append("AND 2=2");
	     }

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()

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

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	
	public void VLUK050_SHR2(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR2");

	    String GBN_CD  = p_box.get("GUBUN");

	    StringBuffer sb = new StringBuffer();
	    
	     if ( GBN_CD.equals("1") ) {  // 정규직
	    	 sb.append("AND A.PAYGRD NOT IN ('300','700','890') AND C.OCC_CD != '8'");
	     } else if ( GBN_CD.equals("2") ) { //계약직 + PJT 2020.11.30 수정함
	    	 sb.append("AND A.PAYGRD IN ('300','700','890') ");
	     } else if ( GBN_CD.equals("3") ) { //PJT
	    	 sb.append("AND C.OCC_CD ='8'");
	     } else {
	    	 sb.append("AND 2=2");
	     }

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()

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

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	
	
	
	public void VLUK050_SHR_01(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR_01");


	    String GBN_CD  = p_box.get("GUBUN");

		StringBuffer sb = new StringBuffer();

	    if ( GBN_CD.equals("1") ) {  // 정규직
			 sb.append("AND A.PAYGRD NOT IN ('300','700','890')");
	     } else if ( GBN_CD.equals("2") ) { //계약직
	    	 sb.append("AND A.PAYGRD IN ('300','700','890')");
	     } else if ( GBN_CD.equals("4") ) { //PJT
	    	 sb.append("AND A.PAYGRD NOT IN ('300','700','890')");
	     } else {
	    	 sb.append("AND 2=2");
	     }
	        
	    StringBuffer sb2 = new StringBuffer();
	    
	     if ( GBN_CD.equals("1") ) {  // 정규직
	    	 sb2.append("AND A.JOBREF!='8'");
	     } else if ( GBN_CD.equals("2") ) { //계약직
	    	 sb2.append("AND 2=2");
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

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUK050_SHR_02(CBox p_box) throws CException {
		/** 부서장 본사 조회 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR_02");

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
				p_box.get("EMPNOH"),                       							// 피고과자
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
		};

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUK050_SHR_03(CBox p_box) throws CException {
		/** 부서장 본사외 조회 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR_03");

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
				p_box.get("EMPNOH"),                       							// 피고과자
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
		};

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUK050_SHR_SCR(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR_SCR");

        String gun_cd;
	    String PAYGRD  = p_box.get("PAYGRD");

	    if ( PAYGRD.equals("140")||PAYGRD.equals("150")||PAYGRD.equals("160")||PAYGRD.equals("170")
	    		||PAYGRD.equals("180")||PAYGRD.equals("190")||PAYGRD.equals("200")||PAYGRD.equals("210")) {
	    	 gun_cd = "2";
	     } else if (PAYGRD.equals("220")||PAYGRD.equals("230")||PAYGRD.equals("240")||PAYGRD.equals("250")
		    		||PAYGRD.equals("260")||PAYGRD.equals("270")||PAYGRD.equals("300")||PAYGRD.equals("700")||PAYGRD.equals("890")) {
	    	 gun_cd = "1";
	     } else {
	    	 gun_cd = "1";
	     }

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
				p_box.get("EMPNO"),                       							// 피고과자
				p_box.get("EVASEQ"),                       							// 차수
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				gun_cd,                       										// 직급
		};

		prop.add("ESCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("GSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("MSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("LSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("PSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR",  prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUK050_SHR_SCR_01(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR_SCR_01");

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("EMPNOH"),                       							// 고과자
				p_box.get("EMPNO"),                       							// 피고과자
				p_box.get("EVASEQ"),                       							// 차수
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월

		};

		prop.add("ESCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("GSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("MSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("LSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("PSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR",  prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	
	public void VLUK050_SHR_ITEM(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR_ITEM");
		
		System.out.println(p_box);	
		
        String gun_cd;
	    String PAYGRD  = p_box.get("JOB_CD");
	    String JOBGBN;

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
	    
	    //과장이하는 공통, 직무 / 차장이상은 공통, 리더십 역량평가 19.11.07 수정
	    if ( p_box.get("JOB_CD").equals("200") || p_box.get("JOB_CD").equals("220") ||  p_box.get("JOB_CD").equals("240") || p_box.get("JOB_CD").equals("890") || p_box.get("JOB_CD").equals("700") || p_box.get("JOB_CD").equals("300") ) {
	    	JOBGBN = "03";
	    } else {
	    	JOBGBN = "02";
	    }
	    
	    
	    Object[] bind = new Object[] {

				p_box.get("ENOH_NO"),                       							// 고과자
				p_box.get("ENO_NO"),                       							// 피고과자
				p_box.get("EVASEQ"),                       							// 차수
				gun_cd,                       												// 직급
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                     // 고과년월	
				p_box.get("HEAD_CD"),                       							// 본부			
				gun_cd, 								// 직급				
				JOBGBN,
		};

		prop.add("ESCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("GSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("MSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("LSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("PSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR",  prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);		

	}	
	
	
	public void VLUK050_SHR_ITEM_01(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR_ITEM_01");
		
		//System.out.println(p_box);	

		Object[] bind = new Object[] {

				p_box.get("ENOH_NO"),                       							// 고과자
				p_box.get("ENO_NO"),                       							// 피고과자
				p_box.get("EVASEQ"),                       							// 차수
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                    // 고과월
	
		};

		prop.add("ESCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("GSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("MSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("LSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("PSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR",  prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);		

	}	
		
	
	public void VLUK050_SHR_CMT(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SHR_CMT");
		
		//System.out.println(p_box);	

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),    
				p_box.get("ENOH_NO"),                       							
				p_box.get("ENO_NO"),                       							
                
	
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);		

	}		
	
	public void VLUK050_CMT(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_CMT");

		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				 p_box.get("REG_YM_SHR").replaceAll("-", "")
			    ,p_box.get("ENOH_NO")
			    ,p_box.get("EMPNO")
			    ,JSPUtil.rns(vo.get("CMMENT" ))
			    //,p_box.get("CMMENT")
	
		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}	
	
	
	public void VLUK050_CMT2(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_CMT2");

		//System.out.println(vo);
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				 JSPUtil.rns(vo.get("CMMENT" ))
			     //p_box.get("CMMENT")				
				,p_box.get("REG_YM_SHR").replaceAll("-", "")
			    ,p_box.get("ENOH_NO")
			    ,p_box.get("EMPNO")

	
		};

		/** CREATE메소드 호출  **/
		//this.insertProcess(sql, bind);
		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);
	}		

	public void VLUK050_SAV(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SAV");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVAYM" ))
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))			
		        ,JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("SCR" ))
		        ,JSPUtil.rns(vo.get("SCRGBN" ))
		        ,JSPUtil.rns(vo.get("HEAD_CD" ))
		        ,JSPUtil.rns(vo.get("DPT_CD" ))
		        ,JSPUtil.rns(vo.get("TEAM_CD" ))
		        ,JSPUtil.rns(vo.get("JOB_CD" ))		        

		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}


	public void VLUK050_SAV_01(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SAV_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                     							// 		
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))			
		        ,JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("SCR" ))
		        ,JSPUtil.rns(vo.get("SCRGBN" ))

		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}

	
	public void VLUK050_SAV_CMT(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_SAV_CMT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                     							// 		
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))			
		        ,JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("SCR" ))
		        ,JSPUtil.rns(vo.get("SCRGBN" ))

		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}	
	
	public void VLUK050_SAV_COR(CBox p_box) throws CException {

	    String sql = "{ call PKG_XF_VLUK050_INS.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}

	public void VLUK050_SAV_COR_01(CBox p_box) throws CException {

	    String sql = "{ call PKG_XF_VLUK050_CON.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}

	public void VLUK050_SAV_COR_02(CBox p_box) throws CException {

	    String sql = "{ call PKG_XF_VLUK050_DPT.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}
	
	public void VLUK050_SAV_COR_03(CBox p_box) throws CException {

	    String sql = "{ call PKG_XF_VLUK050_PJT.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}

	public void VLUK050_UPT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_UPT");
		
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
				
				 p_box.get("REG_YM_SHR").replaceAll("-", "")
			    ,p_box.get("EMPNO")
			    
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	public void VLUK050_UPT_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_UPT_01");
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

	public void VLUK050_DEL_CMT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_DEL_CMT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {			
				 p_box.get("REG_YM_SHR").replaceAll("-", "")
			    ,p_box.get("ENOH_NO")
			    ,p_box.get("EMPNO")

		};
		/** UPDATE메소드 호출  **/
		deleteProcess(sql, bind);
	}	

	public void VLUK050_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVAYM" ))
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))			
		        ,JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		};
		/** UPDATE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	public void VLUK050_DEL_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK050_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                     							// 		
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))			
		        ,JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		};
		/** UPDATE메소드 호출  **/
		deleteProcess(sql, bind);
	}
}
