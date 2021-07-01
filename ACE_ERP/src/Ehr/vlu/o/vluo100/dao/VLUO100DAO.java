package Ehr.vlu.o.vluo100.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class VLUO100DAO extends AbstractDAO {
    /**
     * VLUO100DAO 생성자
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public VLUO100DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass의 생성자 호출 **/
			super(p_dsId, p_tr);
	}

    /**
     * 목표설정 (조회) DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR(CBox p_box ) throws CException {

		/** 외부 XML에서 목표설정 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

				p_box.get("EVL_YYYY"),
                p_box.get("ENO_NO"),
                p_box.get("GOAL_SEQ"),         

		};

		prop.add("SCORE",  ColumnProp.COLUMN_TYPE_DECIMAL, 3.2, ColumnProp.CONSTRAINT_TB_NORMAL);

		prop.add("WEIGHT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.0, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}

	
    /**
     * 정보를 조회 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_22(CBox p_box ) throws CException {

		/** 외부 XML에서 개인별평가일정 정보를 조회 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_22");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("EVL_YYYY"),                      // 해당년도
				p_box.get("ENO_NO"),                       	// 사번
				p_box.get("GOAL_SEQ"),                      // SEQ				
		};

		prop.add("SCORE",  prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);		
		
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	
	
    /**
     * 목표설정 (조회) DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_PRT(CBox p_box ) throws CException {

		/** 외부 XML에서 목표설정 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_PRT");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

				p_box.get("EVL_YYYY"),
                p_box.get("ENO_NO"),
                p_box.get("GOAL_SEQ"),   

		};

		prop.add("WEIGHT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.0, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}	
	
    /**
     * 개인별평가일정 정보를 조회 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_00(CBox p_box ) throws CException {

		/** 외부 XML에서 개인별평가일정 정보를 조회 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_00");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("GUBUN"),                         // 업무구분
				p_box.get("EVL_YY"),                        // 해당년도
				p_box.get("EVL_GBN"),                     // 업적구분
				p_box.get("EVL_FRQ"),                     // 회차
				p_box.get("ENO_NO")                       // 피평가자사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

    /**
     * 평가자조회  DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	
	public GauceDataSet VLUO100_SHR_01(CBox p_box ) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_01");

		//System.out.println(vo);
		//System.out.println(p_box);
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("EVL_YYYY"),                    // 해당년도
				p_box.get("ENO_NO")                      // 피평가자사번

		};

		prop.add("STATUS_NM", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

		return this.selectProcess(sql, bind, prop);

	}


	/**
     * 평가자 결재테이블 조회 시 데이터 없을시 평가대상리스트에서 조회  DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public GauceDataSet VLUO100_SHR_02(CBox p_box ) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				"1"	,													// 목표순번
				p_box.get("EVL_YYYY"),                    // 해당년도
				"1",                     								// 평가차수
				"1",													// 구분(0:Non KPI,1:KPI)
				p_box.get("ENO_NO")                       // 피평가자사번
		};

		prop.add("STATUS", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("STATUS_NM", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK", ColumnProp.COLUMN_TYPE_STRING, 100, ColumnProp.CONSTRAINT_TB_NORMAL);

		return this.selectProcess(sql, bind, prop);

	}

    /**
     * 목표순번 최대값 (조회) DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
    public void VLUO100_SHR_01_OLD(CBox p_box ) throws CException {

        /** 외부 XML에서 목표순번 최대값  (조회) SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_01_OLD");

        /** 검색 조건 Mapping(PrepareStatement ) **/
        Object[] bind = new Object[] {
                p_box.get("GUBUN"),
                p_box.get("EVL_YY"),
                p_box.get("EVL_FRQ"),
                p_box.get("ENO_NO"),
                p_box.get("EVLENO_NO")
        };
        /**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
        this.selectProcessFirstRow(sql, bind, this.prop);

    }

    /**
     * 목표입력 기간 여부 (조회) DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
    public GauceDataSet VLUO100_SHR_03(CBox p_box ) throws CException {

        /** 외부 XML에서 목표입력 기간 여부  (조회) SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_03");

        /** 검색 조건 Mapping(PrepareStatement ) **/
        Object[] bind = new Object[] {
                p_box.get("EVL_YYYY"),
                "1",
                p_box.get("GUBUN"),
                p_box.get("ENO_NO"),
                p_box.get("GOAL_NO")
        };
        /**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
        return this.selectProcess(sql, bind, prop);

    }

    /**
     * 평가대상자 여부 정보를 조회 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_04(CBox p_box ) throws CException {

		/** 외부 XML에서 평가대상자 여부 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUC130_SHR_00");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("GUBUN"),                        // 업무구분
				p_box.get("EVL_YY"),                        // 해당년도
				p_box.get("EVL_GBN"),                     // 업적구분
				p_box.get("EVL_FRQ"),                     // 회차
				p_box.get("ENO_NO")                       // 피평가자사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

    /**
     * 평가일정 조회 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_YMD(CBox p_box ) throws CException {

		/** 외부 XML에서 평가일정 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_YMD");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("SESSION_ENONO")),        //사원번호
				p_box.get("EVL_YYYY"),                 // 해당년도
				"1",									             // 회차
				p_box.get("GUBUN"),                    //구분(0:Non KPI,1:KPI,2:PM)
				p_box.get("ITEM")                         // ITEM 코드(G:목표입력,M:중간면담,C:목표수정,S:본인평가,E:평가자평가,O:결과확인및이의신청)
		};

		prop.add("GOAL_NO", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("STATUS_NM", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
    /**
     * 목표설정 (입력) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_INS(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (입력) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_INS");

		//System.out.println(p_box);	
		//System.out.println(vo);
		
		
		/** 저장 내용  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(vo.get("ENO_NO")), 					//피평가자사번
                JSPUtil.rns(vo.get("GOAL_SEQ")), 				//GOAL_SEQ                
                JSPUtil.rns(vo.get("GOAL_NO")),					//목표순번(수정시마다 순차적 부여)
                JSPUtil.rns(vo.get("GOAL_SEQ")), 				//GOAL_SEQ                   
                JSPUtil.rns(vo.get("CATEGORY")),             	//업무목표
                JSPUtil.rns(vo.get("FORMULA")),             	//세부목표
                JSPUtil.rns(vo.get("GRADE_S")),             	//S
                JSPUtil.rns(vo.get("GRADE_A")),             	//A
                JSPUtil.rns(vo.get("GRADE_B")),             	//B
                JSPUtil.rns(vo.get("GRADE_C")),             	//C
                JSPUtil.rns(vo.get("GRADE_D")),             	//D
                JSPUtil.rns(vo.get("GOALSET_HALF")),    		//상반기목표
                JSPUtil.rns(vo.get("GOALSET_10")),    			//10월목표                   
                JSPUtil.rns(vo.get("GOALSET")),    				//목표
                JSPUtil.rns(vo.get("WEIGHT")),       			//비중

                JSPUtil.rns(p_box.get("vusrid")),        		//사원번호
                JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(vo.get("ENO_NO")), 					//피평가자사번
                JSPUtil.rns(vo.get("GOAL_SEQ")), 				//GOAL_SEQ                
                JSPUtil.rns(vo.get("GOAL_NO")),					//목표순번(수정시마다 순차적 부여)
                JSPUtil.rns(vo.get("CATEGORY")),             	//카테고리
                JSPUtil.rns(vo.get("FORMULA")),             	//세부목표
                JSPUtil.rns(vo.get("GRADE_S")),             	//S
                JSPUtil.rns(vo.get("GRADE_A")),             	//A
                JSPUtil.rns(vo.get("GRADE_B")),             	//B
                JSPUtil.rns(vo.get("GRADE_C")),             	//C
                JSPUtil.rns(vo.get("GRADE_D")),             	//D
                JSPUtil.rns(vo.get("GOALSET_HALF")),    		//상반기목표
                JSPUtil.rns(vo.get("GOALSET_10")),    			//10월목표                   
                JSPUtil.rns(vo.get("GOALSET")),       			//목표
                JSPUtil.rns(vo.get("WEIGHT")),       			//비중

                'S',											//상태값
                JSPUtil.rns(p_box.get("vusrid")),        		//사원번호
                JSPUtil.rns(p_box.get("vusrid"))         		//사원번호
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

    /**
     * 상신 DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SAV_01(CBox p_box,  GauceValueObject vo) throws CException {

		/** 외부 XML에서 목표설정 (입력) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_01");

		/** 저장 내용  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid")),         		//사원번호      
				JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(vo.get("ENO_NO")), 					//피평가자사번
                JSPUtil.rns(vo.get("GOAL_SEQ")),				//목표순번  
                JSPUtil.rns(vo.get("GOAL_NO")),					//목표순번                 
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}	
	
    /**
     * 상신 DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SAV_011(CBox p_box) throws CException {

		/** 외부 XML에서 목표설정 (입력) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_011");

		/** 저장 내용  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid")),         		//사원번호      
				JSPUtil.rns(p_box.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(p_box.get("ENO_NO")), 				//피평가자사번
                JSPUtil.rns(p_box.get("GOAL_SEQ")),				//목표순번  
                
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}		
	
	
    /**
     * 결재 또는 부결 DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SAV_02(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (입력) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SAV_02");

		/** 저장 내용  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(vo.get("ENO_NO")), 					//피평가자사번
                JSPUtil.rns(vo.get("GOAL_SEQ")),				//목표순번          
                JSPUtil.rns(p_box.get("vusrid")),        		//사원번호
                JSPUtil.rns(p_box.get("vusrid"))         		//사원번호
		};

		/** INSERT메소드 호출  **/
		updateProcess(sql, bind);

	}	
	

	
	
    /**
     * 평가자 결재 리스트 저장 DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_INS_01(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (입력) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_INS_01");

		/** 저장 내용  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid")),        		//사원번호
                JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(vo.get("ENO_NO")) 					//피평가자사번
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	
	
    /**
     * 목표설정 (수정) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_UPT(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT");

		/** 수정 조건 및 내용 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("CATEGORY")),		//구분(0:팀KPI연계,1:역량지수)
                JSPUtil.rns(vo.get("KPI")),					//KPI
                JSPUtil.rns(vo.get("FORMULA")),		//산출식
                JSPUtil.rns(vo.get("GRADE_S")),     	//S등급
                JSPUtil.rns(vo.get("GRADE_A")),      	//A등급
                JSPUtil.rns(vo.get("GRADE_B")),      	//B등급
                JSPUtil.rns(vo.get("GRADE_C")),		//C등급
                JSPUtil.rns(vo.get("GRADE_D")),       //D등급
                JSPUtil.rns(vo.get("GOAL_HALF")),        		//목표
                JSPUtil.rns(vo.get("GOAL_10")),        		//목표
                JSPUtil.rns(vo.get("GOAL")),        		//목표
                JSPUtil.rns(vo.get("WEIGHT")),  		//비중
                JSPUtil.rns(vo.get("KPI_SEQ")),			//KPI순번
                JSPUtil.rns(p_box.get("MOD_YN")),			//평가자 수정여부
                JSPUtil.rns(p_box.get("SESSION_ENONO")),	//최종수정자
                JSPUtil.rns(vo.get("EVL_YYYY")),		//해당년도
                JSPUtil.rns(vo.get("EVL_FRQ")),			//평가차수
                JSPUtil.rns(vo.get("ENO_NO")),     		//피평가자사번
                JSPUtil.rns(vo.get("GOAL_NO")), 		//목표순번(수정시마다 순차적 부여)
                JSPUtil.rns(vo.get("SEQ"))					//초기 KPI순번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

    /**
     * 목표설정 승인상태 업데이트 DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_UPT_01(CBox p_box) throws CException {

		/** 외부 XML에서 목표설정 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_01");

		/** 수정 조건 및 내용 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

                JSPUtil.rns(p_box.get("STATUS")),					//상태(R:미결,Y:결재,N:부결)
                JSPUtil.rns(p_box.get("SESSION_ENONO")),	//최종수정자
                JSPUtil.rns(p_box.get("ENO_NO")),     			//피평가자사번

		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
     * 목표설정 승인상태 업데이트 DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_UPT_02(CBox p_box) throws CException {

		/** 외부 XML에서 목표설정 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_02");

		/** 수정 조건 및 내용 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("STATUS")),				//상태(S:저장, R:상신, Y:결재, N:부결)
                JSPUtil.rns(p_box.get("vusrid")),        			//사원번호                 
                JSPUtil.rns(p_box.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(p_box.get("ENO_NO")), 				//피평가자사번 
                JSPUtil.rns(p_box.get("GOAL_SEQ")), 			//GOAL_SEQ                 
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
     * 목표설정 승인상태 업데이트 DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_UPT_03(CBox p_box) throws CException {

		/** 외부 XML에서 목표설정 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_03");

		/** 수정 조건 및 내용 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("STATUS")),				//상태(S:저장, R:상신, Y:결재, N:부결)
                JSPUtil.rns(p_box.get("vusrid")),        			//사원번호                 
                JSPUtil.rns(p_box.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(p_box.get("ENO_NO")), 				//피평가자사번 
                JSPUtil.rns(p_box.get("GOAL_SEQ")), 			//GOAL_SEQ                 
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}	
	


    /**
     * 목표설정 (삭제) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_DEL(CBox p_box, GauceValueObject vo) throws CException {

        //마스터삭제
		/** 외부 XML에서 목표설정 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_DEL");

		/** 삭제 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),		//해당년도
                JSPUtil.rns(vo.get("EVL_FRQ")),			//평가차수
                JSPUtil.rns(vo.get("ENO_NO")),     		//피평가자사번
                JSPUtil.rns(vo.get("GOAL_NO")), 		//목표순번(수정시마다 순차적 부여)
                JSPUtil.rns(vo.get("SEQ"))					//초기 KPI순번
		};
		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}

	/**
     * 목표설정 (전체삭제) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

        //마스터삭제
		/** 외부 XML에서 목표설정 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_DEL_01");

		/** 삭제 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),			//해당년도
                JSPUtil.rns(vo.get("ENO_NO")),     		//피평가자사번
                JSPUtil.rns(vo.get("GOAL_SEQ")),     	//GOAL_SEQ                
		};
		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}

}
