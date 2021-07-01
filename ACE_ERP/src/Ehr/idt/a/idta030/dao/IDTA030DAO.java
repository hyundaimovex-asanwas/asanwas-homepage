package Ehr.idt.a.idta030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class IDTA030DAO extends AbstractDAO {
	/**
	 * IDTA030DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTA030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 증명서신청현황을 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_SHR(CBox p_box) throws CException {

		String STR_YMD_SHR    = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR    = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String CEF_SEC_SHR    = JSPUtil.rns(p_box.get("CEF_SEC_SHR")); // 증명서(재직,경력,퇴직,자동차)
		String CEF_STS_SHR    = JSPUtil.rns(p_box.get("CEF_STS_SHR")); // 조회조건(저장,신청,반송,발급,직접출력)
        String REQ_NO         	= JSPUtil.rns(p_box.get("REQ_NO"));

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
        };

		/** 조회 조건(사용일자)에 따른 처리 **/
		StringBuffer sb = new StringBuffer();
		if (!STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.REQ_YMD >= '"+STR_YMD_SHR+"' \n");
			sb.append("AND A.REQ_YMD <= '"+END_YMD_SHR+"' \n");
		} else if (!STR_YMD_SHR.equals("") && END_YMD_SHR.equals("")) {
			sb.append("AND A.REQ_YMD >= '"+STR_YMD_SHR+"' \n");
		} else if (STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.REQ_YMD <= '"+END_YMD_SHR+"' \n");
		}

		// 증명서 구분
		if( !CEF_SEC_SHR.equals("0")
                && !CEF_SEC_SHR.equals("")){
			sb.append("AND A.CEF_SEC = '"+CEF_SEC_SHR+"' \n");
		}
		// 조회조건(진행상태)
		if( !CEF_STS_SHR.equals("0")
                && !CEF_STS_SHR.equals("")){
			sb.append("AND A.CEF_STS = '"+CEF_STS_SHR+"' \n");
		}

        if(!REQ_NO.equals("")) {
            sb.append("AND A.REQ_NO = '"+REQ_NO+"'");
        }

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
			sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		prop.add("CEF_STS", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("CET_NO", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 사원 정보(HDPS)를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_SHR_01");

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("vusrid"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 사원 정보(주소)를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("ENO_NO"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 증명서 발급 정보를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_INS");

        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());	  		
		
		String YEAR   = JSPUtil.rns(p_box.get("vcurdate")).substring(0,4);

        //System.out.println("SESSION_TODAY   =========================================== " + SESSION_TODAY);	
    	//System.out.println("YEAR"+YEAR);		
		
		String SPL_YEAR = YEAR;
		if( JSPUtil.rns(vo.get("SPL_YMD")).equals("")){
			SPL_YEAR = "";
		}
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				YEAR+"ID",
                YEAR+"ID",// 신청번호(년도+부서코드+001)
				JSPUtil.rns(vo.get("ENO_NO")),     // 신청자사번
				JSPUtil.rns(vo.get("CEF_SEC")),    // 신청서종류
				JSPUtil.rns(vo.get("CEF_RSN")),    // 용도
				JSPUtil.rns(vo.get("CEF_CNT")),    // 매수
				SPL_YEAR,SPL_YEAR,SPL_YEAR,        // 발급번호 (년도+"-"+0001)
				JSPUtil.rns(vo.get("REQ_YMD")).replaceAll("-", ""),    // 신청일자
				JSPUtil.rns(vo.get("SPL_YMD")).replaceAll("-", ""),    // 발급일자
				JSPUtil.rns(vo.get("CEF_STS")),    // 발급
				JSPUtil.rns(vo.get("PRT_YMD")).replaceAll("-", ""),    // 첨부문서출력일
				JSPUtil.rns(vo.get("REMARK")),     // 비고
				JSPUtil.rns(p_box.get("vusrid")),
				// 최초등록일
				JSPUtil.rns(p_box.get("vusrid")),
				// 최종수정일
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns(vo.get("CITY"))
			};

			/** INSERT메소드 호출  **/
			insertProcess(sql, bind);
		}

	/**
	 * 증명서신청 정보를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_UPT");

		String SPL_YEAR = JSPUtil.rns(p_box.get("vcurdate")).substring(0,4);

		if( JSPUtil.rns(vo.get("SPL_YMD")).equals("")){
			SPL_YEAR = "";
		}
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("CEF_SEC")),    // 신청서종류
				JSPUtil.rns(vo.get("CEF_RSN")),    // 용도
				JSPUtil.rns(vo.get("CEF_CNT")),    // 매수
				JSPUtil.rns(vo.get("SPL_YMD")).replaceAll("-", ""),    // 발급일자
				SPL_YEAR,SPL_YEAR,SPL_YEAR,        // 발급번호 (년도+"-"+0001)    // 발급일자
				JSPUtil.rns(vo.get("CEF_STS")),    // 발급
				JSPUtil.rns(vo.get("PRT_YMD")).replaceAll("-", ""),    // 첨부문서출력일
				JSPUtil.rns(vo.get("REMARK")),     // 비고
				JSPUtil.rns(p_box.get("vusrid")),

				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns(vo.get("CITY")),

				JSPUtil.rns(vo.get("REQ_NO"))
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

    /**
     * 증명서 출력일자를 수정한다.
     * @param p_box
     * @throws CException
     */
	public void IDTA030_UPT_PRT(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("idt", "IDTA030_UPT_PRT");
	    
	    //System.out.println("--------------------->>>>>>>>>>>>>>>>>>>>>>>>>>");
	    
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("vusrid")),
	            JSPUtil.rns(p_box.get("REQ_NO"))
	    };

	    /** UPDATE메소드 호출  **/
	    updateProcess(sql, bind);
	}

	/**
	 * 증명서신청 정보를 삭제하는  DAO메소드.
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void IDTA030_DEL(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}
}
