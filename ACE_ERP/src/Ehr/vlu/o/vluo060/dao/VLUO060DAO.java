package Ehr.vlu.o.vluo060.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;


public class VLUO060DAO extends AbstractDAO {
    /**
     * VLUO060DAO 생성자
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public VLUO060DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass의 생성자 호출 **/
			super(p_dsId, p_tr);
	}

    /**
     * 팀원 리스트 (조회) DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO060_SHR(CBox p_box ) throws CException {

		/** 외부 XML에서 목표설정 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_SHR");

		
	    String GBN_CD  = p_box.get("GUBUN");

	    StringBuffer sb = new StringBuffer();
	    
	     if ( GBN_CD.equals("1") ) {  // 정규직
	    	 sb.append("AND A.OCC_CD != '8'");
	     } else if ( GBN_CD.equals("2") ) { //PJT
	    	 sb.append("AND A.OCC_CD ='8'");
	     } else {
	    	 sb.append("AND 2=2");
	     }

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()

		};

		
		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);		
		
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR"),
                p_box.get("EMPNOH"),   
				p_box.get("REG_YM_SHR"),
				p_box.get("REG_YM_SHR"),
                p_box.get("EMPNOH"),      
				p_box.get("REG_YM_SHR"),
		};

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);		
		prop.add("DPT_CH_SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);	
		
		
		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}

	
	public void VLUO060_SHR2(CBox p_box ) throws CException {

		/** 외부 XML에서 목표설정 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_SHR2");

		
	    String GBN_CD  = p_box.get("GUBUN");

	    StringBuffer sb = new StringBuffer();
	    
	     if ( GBN_CD.equals("1") ) {  // 정규직
	    	 sb.append("AND A.OCC_CD != '8'");
	     } else if ( GBN_CD.equals("2") ) { //PJT
	    	 sb.append("AND A.OCC_CD ='8'");
	     } else {
	    	 sb.append("AND 2=2");
	     }

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()

		};

		
		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);		
		
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR"),
                p_box.get("EMPNOH"),   
				p_box.get("REG_YM_SHR"),
				p_box.get("REG_YM_SHR"),
                p_box.get("EMPNOH"),      
				p_box.get("REG_YM_SHR"),  
 
		};

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);		
		prop.add("DPT_CH_SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);		
		
		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}	
	

    /**
     * 조회 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO060_SHR_ITEM(CBox p_box ) throws CException {

		/** 외부 XML에서 평가일정 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_SHR_ITEM");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("HENO_NO"),                       						// 고과자
				p_box.get("ENO_NO"),                       							// 피고과자
				p_box.get("GOAL_SEQ"),                       						// 차수
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                     	// 고과년월
				p_box.get("ENO_NO"),   												// 피고과자				
				p_box.get("GOAL_SEQ"),                       						// 차수				
				
		};

		
		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	
	
    /**
     * 목표설정 (입력) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO060_INS(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (입력) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_INS");

		/** 저장 내용  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                
		         JSPUtil.rns(vo.get("EVL_YYYY" ))
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("GOAL_NO" ))
		        ,JSPUtil.rns(vo.get("WEIGHT" ))
		        ,JSPUtil.rns(vo.get("SCR" ))
		        ,JSPUtil.rns(vo.get("SCRGBN" ))
		        ,JSPUtil.rns(vo.get("DPT_CH_SCR" ))
		        ,JSPUtil.rns(vo.get("FEEDBACK" ))                
                
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}


	
	public void VLUO060_SAV_COR(CBox p_box) throws CException {

	    String sql = "{ call PKG_XF_VLUO060_INS.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}	
	
	
	public void VLUO060_SAV_COR_01(CBox p_box) throws CException {

	    String sql = "{ call PKG_XF_VLUO060_PJT.PROC_CORRECT(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}		
	
    /**
     * 목표설정 (수정) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO060_UPT(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_UPT");

		/** 수정 조건 및 내용 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("WEIGHT_HEAD")),  	//비중
                JSPUtil.rns(vo.get("EMPNO")), 			//                
                JSPUtil.rns(vo.get("EVASEQ")), 			//
                JSPUtil.rns(vo.get("GOAL_NO")), 		//

		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	

	
	
	
	public void VLUO060_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_DEL");
     
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVL_YYYY" ))
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("GOAL_NO" ))
		};
		/** UPDATE메소드 호출  **/
		deleteProcess(sql, bind);
	}

}
