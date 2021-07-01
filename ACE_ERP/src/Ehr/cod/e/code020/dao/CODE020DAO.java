package Ehr.cod.e.code020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODE020DAO extends AbstractDAO {
	/**
	 * PIRA060DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODE020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 일련번호 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void CODE020_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 일련번호 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("vusrid")
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 개인정보 수정요청 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void CODE020_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 개인정보 수정요청 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_SHR_02");

		/** 조회 조건(조회기간)에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();
		if (!p_box.get("STR_YMD").equals("")) {
			sb.append("AND    TO_CHAR(A.IPT_YMD, 'YYYY-MM-DD') >= '"+p_box.get("STR_YMD")+"' \n");
		}
		if (!p_box.get("END_YMD").equals("")) {
			sb.append("	AND    TO_CHAR(A.IPT_YMD, 'YYYY-MM-DD') <= '"+p_box.get("END_YMD")+"' \n");
		}

		String sts_gbn1 = "STS_GBN = '0'";
		String sts_gbn2 = "STS_GBN = '0'";
		String sts_gbn3 = "STS_GBN = '0'";

		if(p_box.get("STS_GBN1").equals("1")){
			sts_gbn1 = "STS_GBN = '1'";
		}
		if(p_box.get("STS_GBN2").equals("2")){
			sts_gbn2 = "STS_GBN = '2'";
		}
		if(p_box.get("STS_GBN3").equals("3")){
			sts_gbn3 = "STS_GBN = '3'";
		}

		/** 조회 조건(처리단계)에 따른 처리 #2 **/
		StringBuffer sb1 = new StringBuffer();

		sb1.append("AND    ( "+sts_gbn1+" OR "+sts_gbn2+" OR "+sts_gbn3+" ) \n");


		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb1.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),				// 사번

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 일련번호 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void CODE020_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 일련번호 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_SHR_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("SEQ_ENO_NO")
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
     * 개인정보 수정요청 저장 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void CODE020_INS(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 개인정보 수정요청 (저장) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("SEQ_NO")),			//일련번호
				JSPUtil.rns(vo.get("ENO_NO")),			//사원번호
				JSPUtil.rns(vo.get("UPDATE_TXT")),		//수정사항
				JSPUtil.rns(vo.get("WORK_GBN")),		//업무구분
				JSPUtil.rns(vo.get("STS_GBN")),			//처리상황
				JSPUtil.rns(vo.get("REPLY_TXT")),		//총무부 답신
				p_box.get("vusrid"),
				p_box.get("vusrid")
		};


		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);

	}

	/**
     * 개인정보 수정요청 수정 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void CODE020_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서개인정보 수정요청 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_UPT");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("UPDATE_TXT")),		//수정사항
				JSPUtil.rns(vo.get("WORK_GBN")),		//업무구분
				JSPUtil.rns(vo.get("STS_GBN")),			//처리상황
				JSPUtil.rns(vo.get("REPLY_TXT")),		//총무부 답신
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("SEQ_NO")),			//일련번호
				JSPUtil.rns(vo.get("ENO_NO"))			//사원번호
		};


		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}

	/**
     * 개인정보 수정요청 삭제 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void CODE020_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 개인정보 수정요청 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_DEL");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("SEQ_NO")),			//일련번호
				JSPUtil.rns(vo.get("ENO_NO"))			//사원번호
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}


}
