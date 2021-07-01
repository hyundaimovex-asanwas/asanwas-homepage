package Ehr.idt.a.idta010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class IDTA010DAO extends AbstractDAO {
	/**
	 * IDTA010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 증명서발급처리 정보를 조회해 오는 DAO메소드(인쇄용)
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA010_SHR(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_SHR");

        String STR_YMD      = JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", "");
        String END_YMD      = JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", "");
        String CEF_STS      = JSPUtil.rns(p_box.getString("CEF_STS"));


        /** 조회 조건(사용일자)에 따른 처리 **/
        StringBuffer sb = new StringBuffer();
        if (!STR_YMD.equals("") && !END_YMD.equals("")) {
            sb.append("               AND DECODE(A.CEF_STS,'E',A.SPL_YMD,'F',A.SPL_YMD,A.REQ_YMD) >= '"+STR_YMD+"' \n");
            sb.append("               AND DECODE(A.CEF_STS,'E',A.SPL_YMD,'F',A.SPL_YMD,A.REQ_YMD) <= '"+END_YMD+"' \n");
        } else if (!STR_YMD.equals("") && END_YMD.equals("")) {
            sb.append("               AND DECODE(A.CEF_STS,'E',A.SPL_YMD,'F',A.SPL_YMD,A.REQ_YMD) >= '"+STR_YMD+"' \n");
        } else if (STR_YMD.equals("") && !END_YMD.equals("")) {
            sb.append("               AND DECODE(A.CEF_STS,'E',A.SPL_YMD,'F',A.SPL_YMD,A.REQ_YMD) <= '"+END_YMD+"' \n");
        }

        // 조회조건
        if ( !CEF_STS.equals("")){
            sb.append("               AND A.CEF_STS = '"+CEF_STS+"' \n");
        } else if (CEF_STS.equals("")) {
            sb.append("               AND A.CEF_STS <> 'A' \n");
	    }

        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {
            sb.toString()
        };

        /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
		        ""
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

    /**
     * 증명서 발급 정보를 저장하는 DAO 메소드.
     * @param vo
     * @param p_box
     * @throws CException
	 */
	public void IDTA010_INS_TEMP(GauceValueObject vo, CBox p_box) throws CException {
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("idt", "IDTA010_INS_TEMP");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid"))
               ,JSPUtil.rns(vo.get("REQ_NO"))
               ,JSPUtil.rns(vo.get("ENO_NO"))
        };

        this.insertProcess(sql, bind);
	}

    /**
     * 대상자 내역을 삭제하는 DAO 메소드.
     * @param p_box
     * @throws CException
     */
	public void IDTA010_DEL_TEMP(CBox p_box) throws CException {
	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("idt", "IDTA010_DEL_TEMP");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	             JSPUtil.rns(p_box.get("vusrid"))
	    };

	    this.deleteProcess(sql, bind);
	}

}