package Ehr.vlu.o.vluo070.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class VLUO070DAO extends AbstractDAO {
    /**
     * VLUO070DAO 생성자
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public VLUO070DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass의 생성자 호출 **/
			super(p_dsId, p_tr);
	}

    /**
     * 팀원 리스트 (조회) DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO070_SHR(CBox p_box ) throws CException {

		/** 외부 XML에서 목표설정 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO070_SHR");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

				p_box.get("EVL_YYYY"),			
                p_box.get("ENO_NO"),
                p_box.get("STATUS"),           

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}


    /**
     * 팀 조회 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO070_SHR_TEAM(CBox p_box ) throws CException {

		/** 외부 XML에서 평가일정 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO070_SHR_TEAM");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO"),                    //사원번호
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	
	
    /**
     * FILE 조회 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO070_SHR_FILE(CBox p_box ) throws CException {

		/** 외부 XML에서 평가일정 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO070_SHR_FILE");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                    					//사원번호
				p_box.get("MEET_NO"),                    					//순번	
				p_box.get("EVL_YYYY"),                    					//연도				

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}	
	
    /**
     * 목표설정 (입력) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO070_INS(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (입력) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO070_INS");

		/** 저장 내용  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(vo.get("ENO_NO")), 					//피평가자사번
                JSPUtil.rns(vo.get("GOAL_NO")),					//목표순번(수정시마다 순차적 부여)
                JSPUtil.rns(vo.get("CATEGORY")),             	//업무목표
                JSPUtil.rns(vo.get("FORMULA")),             	//세부목표
                JSPUtil.rns(vo.get("GOALSET_HALF")),    		//상반기목표
                JSPUtil.rns(vo.get("GOALSET_10")),    			//10월목표                
                JSPUtil.rns(vo.get("GOALSET")),    				//목표
                JSPUtil.rns(vo.get("WEIGHT")),       			//비중
                JSPUtil.rns(vo.get("DIFFICULTY")),       		//난이도
                JSPUtil.rns(p_box.get("vusrid")),        		//사원번호
                JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(vo.get("ENO_NO")), 					//피평가자사번
                JSPUtil.rns(vo.get("GOAL_NO")),					//목표순번(수정시마다 순차적 부여)
                JSPUtil.rns(vo.get("CATEGORY")),             	//카테고리
                JSPUtil.rns(vo.get("FORMULA")),             	//세부목표
                JSPUtil.rns(vo.get("GOALSET")),       			//목표
                JSPUtil.rns(vo.get("WEIGHT")),       			//비중
                JSPUtil.rns(vo.get("DIFFICULTY")),       		//난이도                
                JSPUtil.rns(p_box.get("vusrid")),        		//사원번호
                JSPUtil.rns(p_box.get("vusrid"))         		//사원번호
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
	public void VLUO070_UPT(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO070_UPT");

		/** 수정 조건 및 내용 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("CATEGORY")),		//구분(0:팀KPI연계,1:역량지수)
                JSPUtil.rns(vo.get("KPI")),					//KPI
                JSPUtil.rns(vo.get("FORMULA")),		//산출식
                JSPUtil.rns(vo.get("GOAL")),        		//목표
                JSPUtil.rns(vo.get("GRADE_S")),     	//S등급
                JSPUtil.rns(vo.get("GRADE_A")),      	//A등급
                JSPUtil.rns(vo.get("GRADE_B")),      	//B등급
                JSPUtil.rns(vo.get("GRADE_C")),		//C등급
                JSPUtil.rns(vo.get("GRADE_D")),       //D등급
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
     * 파일 (입력) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO070_INS_FILE(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (입력) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO070_INS_FILE");

		/** 저장 내용  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(vo.get("TEAM_CD")), 				//소속
                JSPUtil.rns(vo.get("JOB_CD")),					//직위
                JSPUtil.rns(vo.get("ENO_NO")),             		//사번 
				JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도                
                JSPUtil.rns(vo.get("ENO_NO")),             		//사번                    
                JSPUtil.rns(vo.get("MEET_GBN")),             	//MEET_GBN  
                JSPUtil.rns(vo.get("FILE_KEY")),             	//FILE_KEY                 
                JSPUtil.rns(p_box.get("vusrid")),        		//사원번호
                JSPUtil.rns(p_box.get("vusrid"))         		//사원번호
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}	
	
    /**
     * 파일 (수정) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO070_UPT_FILE(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 목표설정 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO070_UPT_FILE");
		
		/** 수정 조건 및 내용 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

                JSPUtil.rns(vo.get("FILE_KEY")),             	//FILE_KEY                 
                JSPUtil.rns(p_box.get("vusrid")),        		//사원번호
				JSPUtil.rns(vo.get("EVL_YYYY")),				//해당년도
                JSPUtil.rns(vo.get("ENO_NO")),             		//사번 				
                JSPUtil.rns(vo.get("MEET_NO")),             	//MEET_NO  
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	
}
