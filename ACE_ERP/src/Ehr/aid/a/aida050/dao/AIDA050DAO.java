package Ehr.aid.a.aida050.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class AIDA050DAO extends AbstractDAO {
	/** 
	 * AIDA050DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이 
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public AIDA050DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}
	
	/**
	 * 경공조금지급기준 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA050_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA050_SHR");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("CEF_SEC_SHR"))
        };
		
		prop.add("AID_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 경공조금지급기준 정보를 등록하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA050_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA050_INS");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("CEF_SEC")),
                JSPUtil.rns(vo.get("AID_CD")),
                JSPUtil.rns(vo.get("JOB_CD_FROM")),
                JSPUtil.rns(vo.get("JOB_CD_TO")),
                JSPUtil.rns(vo.get("LSE_YY1")),
                JSPUtil.rns(vo.get("LSE_YY2")),
				JSPUtil.rns(vo.get("AID_AMT")),
				JSPUtil.rns(vo.get("AID_RPT")),
				JSPUtil.rns(vo.get("REMARK")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid"))
		};
		
		/** UPDATE메소드 호출  **/
		insertProcess(sql, bind);
	}
    
	/**
	 * 경공조금지급기준 정보를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA050_UPT(GauceValueObject vo, CBox p_box) throws CException {
	    
	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA050_UPT");
	    
	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(vo.get("AID_AMT")),
	            JSPUtil.rns(vo.get("AID_RPT")),
                JSPUtil.rns(vo.get("JOB_CD_TO")),
                JSPUtil.rns(vo.get("LSE_YY2")),
	            JSPUtil.rns(vo.get("REMARK")),
	            JSPUtil.rns(p_box.get("vusrid")),
	            JSPUtil.rns(vo.get("CEF_SEC")),
	            JSPUtil.rns(vo.get("AID_CD")),
                JSPUtil.rns(vo.get("JOB_CD_FROM")),
                JSPUtil.rns(vo.get("LSE_YY1"))
	    };
	    
	    /** UPDATE메소드 호출  **/
	    updateProcess(sql, bind);
	}
    
	/**
	 * 경공조금지급기준 정보를 삭제하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA050_DEL(GauceValueObject vo, CBox p_box) throws CException {
	    
	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA050_DEL");
	    
	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("CEF_SEC")),
                JSPUtil.rns(vo.get("AID_CD")),
                JSPUtil.rns(vo.get("JOB_CD_FROM")),
                JSPUtil.rns(vo.get("LSE_YY1"))
	    };
	    
	    /** UPDATE메소드 호출  **/
	    deleteProcess(sql, bind);
	}
}
