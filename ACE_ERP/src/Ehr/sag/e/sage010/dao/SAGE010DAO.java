package Ehr.sag.e.sage010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SAGE010DAO extends AbstractDAO {

	/**
	 * SAGD010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGE010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGE010_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE010_SHR");

		//System.out.print(">>>>>>>>>>>>>>>>>>  PIS_YM = " +p_box.get("PIS_YM"));

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(5, 7),
				p_box.get("SITE_CD"),
				p_box.get("SITE_CD"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM").replaceAll("-", ""),

		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �Ҽ� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGE010_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE010_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),//�Է���
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}



	/**
	 * ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGE010_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns3(vo.get("BAS_AMT")),
				JSPUtil.rns3(vo.get("DUTY_AMT")),
				JSPUtil.rns3(vo.get("LAW_AMT")),
				JSPUtil.rns3(vo.get("BNS_AMT")),
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(p_box.get("vusrid"))//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �޿����̺� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGE010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		int ATT_H = 0;
		int ATT_W = 0;



		for(int i=1;i<=31;i++){
			if(vo.get("AT"+i+"_CD").equals("O")){
				ATT_W = ATT_W + 1;
			}else if(vo.get("AT"+i+"_CD").equals("X")){
				ATT_H = ATT_H + 1;
			}else if(vo.get("AT"+i+"_CD").equals("Y")){
				ATT_H = ATT_H + 1;
			}
		}


		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE010_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("AT1_CD"),
				vo.get("AT2_CD"),
				vo.get("AT3_CD"),
				vo.get("AT4_CD"),
				vo.get("AT5_CD"),
				vo.get("AT6_CD"),
				vo.get("AT7_CD"),
				vo.get("AT8_CD"),
				vo.get("AT9_CD"),
				vo.get("AT10_CD"),
				vo.get("AT11_CD"),
				vo.get("AT12_CD"),
				vo.get("AT13_CD"),
				vo.get("AT14_CD"),
				vo.get("AT15_CD"),
				vo.get("AT16_CD"),
				vo.get("AT17_CD"),
				vo.get("AT18_CD"),
				vo.get("AT19_CD"),
				vo.get("AT20_CD"),
				vo.get("AT21_CD"),
				vo.get("AT22_CD"),
				vo.get("AT23_CD"),
				vo.get("AT24_CD"),
				vo.get("AT25_CD"),
				vo.get("AT26_CD"),
				vo.get("AT27_CD"),
				vo.get("AT28_CD"),
				vo.get("AT29_CD"),
				vo.get("AT30_CD"),
				vo.get("AT31_CD"),
				Integer.toString(ATT_H),
				Integer.toString(ATT_W),
				p_box.get("vusrid"),
				vo.get("PIS_YYMM").substring(0, 4),
				vo.get("PIS_YYMM").substring(5, 7),
				vo.get("ENO_NO"),
		};
		/** INSERT�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}


}
