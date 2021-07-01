package common.popup.chgpwd.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.StringUtil;
import com.shift.gef.support.vo.GauceValueObject;
import common.util.JSPUtil;
import common.util.EncryptUtil;

public class CHGPWDDAO extends AbstractDAO {
    /**
     * CHGPWDDAO 생성자
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public CHGPWDDAO(String p_conn, TrBox p_tr) throws CException {

			/** SuperClass의 생성자 호출 **/
			super(p_conn, p_tr);
	}

    /**
     * 기존비밀번호 (조회) DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public GauceDataSet CHGPWD_SHR(CBox p_box ) throws CException {

		/** 외부 XML에서 기존비밀번호 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "CHGPWD_SHR");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                p_box.get("SESSION_GUBUN"),
				p_box.get("txtENO_NO")
		};
		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		
		return this.selectProcess(sql, bind, this.prop);

	}

    /**
     * 사용자 비밀번호 변경  (수정) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void CHGPWD_UPT(CBox p_box, GauceValueObject vo ) throws CException {

		/** 외부 XML에서 사용자 비밀번호 변경  (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "CHGPWD_UPT");

		/** 수정 조건 및 내용 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				
				//StringUtil.encrypt(vo.get("PWD_NO")),//신규비밀번호

				EncryptUtil.SHA256Encrypt(vo.get("PWD_NO")),		//신규비밀번호 2014/07/09 발등에 불떨어져서 이동훈
				
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//최종수정자
                JSPUtil.rns(p_box.get("SESSION_GUBUN")),//회계단위
                JSPUtil.rns(vo.get("ENO_NO"))//사원번호
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

}
