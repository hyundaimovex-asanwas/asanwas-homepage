package Ehr.edu.g.edug030.dao;

import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUG030DAO extends AbstractDAO {
	/**
	 * EDUG030DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUG030DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG030_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR");

		StringBuffer sb = new StringBuffer();
		
		if(p_box.get("MNT_GBN").equals("M") && p_box.get("ENO_NO").equals("2040024")){
			sb.append(" AND A.TRA_ENO_NO = '2040024' ");
		}else if(p_box.get("MNT_GBN").equals("M") && p_box.get("ENO_NO").equals("2070027")){
			sb.append(" AND A.TRA_ENO_NO = '2070027' ");			
		}else if(p_box.get("MNT_GBN").equals("M") && p_box.get("ENO_NO").equals("2120008")){
			sb.append(" AND A.TRA_ENO_NO = '2120008' ");		
		}else if(p_box.get("MNT_GBN").equals("M") && p_box.get("ENO_NO").equals("2130021")){
			sb.append(" AND A.TRA_ENO_NO = '2130021' ");			
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170006")){
			sb.append(" AND A.ENO_NO = '2170006' ");			
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170007")){
			sb.append(" AND A.ENO_NO = '2170007' ");				
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170008")){
			sb.append(" AND A.ENO_NO = '2170008' ");			
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170009")){
			sb.append(" AND A.ENO_NO = '2170009' ");				
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170012")){
			sb.append(" AND A.ENO_NO = '2170012' ");						
		}else{	
			sb.append(" AND 1=1            ");
		}		
		
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);			
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				//p_box.get("ENO_NO")                         // 사번
				
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG030_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // 피후견인
				p_box.get("TRA_WEEK")                        // SEQ번호
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	public void EDUG030_SHR_31(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_31");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // 피후견인
				p_box.get("TRA_WEEK")                        // SEQ번호
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	public void EDUG030_SHR_32(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_32");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // 피후견인
				p_box.get("TRA_WEEK"),                       // SEQ번호
				p_box.get("TRA_YMD")                         // SEQ번호				
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	public void EDUG030_SHR_33(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_33");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // 피후견인
				p_box.get("TRA_WEEK"),                       // SEQ번호
				p_box.get("TRA_YMD")                         // SEQ번호				
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	

	public void EDUG030_SHR_34(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_34");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // 피후견인
				p_box.get("TRA_YMD")                         // SEQ번호				
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	public void EDUG030_SHR_35(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_35");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // 피후견인
				p_box.get("TRA_YMD")                         // SEQ번호				
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_INS");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                     // 사번
				vo.get("TRA_WEEK"),                                  // 순번
				vo.get("TRA_YMD").replaceAll("-", ""),     			// 일자
				vo.get("TRA_PLACE"),                                 // 장소
				vo.get("TRA_SUBJECT"),                              // 주제
				vo.get("TRA_ENO_NO"),                              // 교육자
				vo.get("TRA_CONTENT"),                            // 교육내용
				vo.get("TRA_REMARK"),                              // 의견
				p_box.get("vusrid"),                 				  // 입력자
				p_box.get("vusrid")                  				  // 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * SUBMIT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_SUB(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SUB");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                     // 사번
				vo.get("TRA_WEEK"),                                  // 순번
				vo.get("TRA_YMD").replaceAll("-", ""),     			// 일자

		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}
	
	/**
	 * 결재상신을 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_SUB2(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_APP");
		
		
		String REQ_NO = vo.get("ENO_NO") + vo.get("TRA_YMD").replaceAll("-", "").substring(4,8);		
		String GUN_DPT;
		String ENO_NO;
		String JOB_CD;	

		
		if(p_box.get("ENO_NO").equals("2170006") || p_box.get("ENO_NO").equals("2170007") || p_box.get("ENO_NO").equals("2170012")){
			
			GUN_DPT = "II30";
			ENO_NO = "2120021";
			JOB_CD = "140"; 
			
		}else if(p_box.get("ENO_NO").equals("2170008")){
			
			GUN_DPT = "KK80";			
			ENO_NO = "2030009";		
			JOB_CD = "180"; 
			
		}else if(p_box.get("ENO_NO").equals("2170009")){
			
			GUN_DPT = "KK70";			
			ENO_NO = "1990040";				
			JOB_CD = "180";
					
		}else{
			
			GUN_DPT = "CC20";	
			ENO_NO = "6060002";			
			JOB_CD = "200";
			
		}

		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				REQ_NO,
				"1",
				"L",
				GUN_DPT,
				vo.get("ENO_NO"),                                     // 상신자				
				ENO_NO,                                                 // 결재자
				JOB_CD,
				vo.get("ENO_NO"),                                     // 사번
				vo.get("ENO_NO"),                                     // 상신자				
				vo.get("TRA_YMD").replaceAll("-", ""),     			// 일자

		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	
	
	
	/**
	 * SUBMIT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_ACC(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_ACC");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                     // 사번
				vo.get("TRA_YMD").replaceAll("-", ""),     			// 일자

		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	
	
	/**
	 * SUBMIT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_ACC2(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_ACC2");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),                  				        // 승인자				
				p_box.get("REQ_NO"),                                      // REQ_NO


		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}		
	
	/**
	 * UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  수정하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상) **/
		Object[] bind = new Object[] {

				vo.get("TRA_PLACE"),                         // 교육장소
				vo.get("TRA_SUBJECT"),                      // 교육주제
				vo.get("TRA_ENO_NO"),                      // 교육자
				vo.get("TRA_CONTENT"),                     // 교육내용
				vo.get("TRA_REMARK"),                      // 건의및의견
				p_box.get("vusrid"),                           // 입력자				
				p_box.get("vusrid"),                           // 수정자
				vo.get("ENO_NO"),                            // 사번
				vo.get("TRA_WEEK"),                          // 교육주
				vo.get("TRA_YMD").replaceAll("-", ""),     // 교육일자				
		};

		/** UPDATE 메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_UPT2(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  수정하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_UPT2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상) **/
		Object[] bind = new Object[] {

				vo.get("TRA_MENTO"),                       // 멘토의견							
				p_box.get("vusrid"),                           // 수정자
				vo.get("ENO_NO"),                            // 사번
				vo.get("TRA_WEEK"),                          // 교육주
				vo.get("TRA_YMD").replaceAll("-", ""),     // 교육일자				
		};

		/** UPDATE 메소드 호출  **/
		updateProcess(sql, bind);
	}	


	/**
	 * DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                       // 일련번호
				vo.get("ENO_NO")                                        // 사번
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}

}
