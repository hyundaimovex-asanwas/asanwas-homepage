package Ehr.common.popup.commnm.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class COMMNMDAO extends AbstractDAO {
	/**
	 * COMMNMDAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public COMMNMDAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 공통 정보를 조회해 오는  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void COMMNM_SHR(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR");

		//System.out.println("p_box=================="+p_box);

		//System.out.println("COMM_CD_SHR=================="+p_box.getString("COMM_CD_SHR"));		
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("CD_GBN"))
			   ,JSPUtil.rns(p_box.get("OCC_CD"))
               ,JSPUtil.rns(p_box.getString("COMM_CD_SHR"))
               ,JSPUtil.rns(p_box.getString("COMM_CD_SHR"))
		};

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 공통 정보의 기준코드 gbn2_tag 사용해 조회해 오는 WORK메소드.
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void COMMNM_SHR_03(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_03");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN")
			   ,JSPUtil.rns(p_box.get("OCC_CD"))
               ,JSPUtil.rns(p_box.getString("COMM_CD_SHR"))
               ,JSPUtil.rns(p_box.getString("COMM_CD_SHR"))
		};

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

}
