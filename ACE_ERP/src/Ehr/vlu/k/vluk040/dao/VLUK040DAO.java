package Ehr.vlu.k.vluk040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class VLUK040DAO extends AbstractDAO {
	/**
	 * VLUK040DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public VLUK040DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	public void VLUK040_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �򰡱������� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK040_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                      // ������
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                      // ������
				p_box.get("DPT_CD_SHR").replaceAll("-", ""),                      // �Ҽ�
				p_box.get("JOB_CD_SHR").replaceAll("-", ""),                      // ����
				p_box.get("ENO_NO_SHR").replaceAll("-", ""),                      // �ǰ���ڻ��

		};
		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK040_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� ���κ�����Ȳ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK040_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                      // ������
				p_box.get("DPT_CD_SHR").replaceAll("-", ""),                      // �Ҽ�
				p_box.get("JOB_CD_SHR").replaceAll("-", ""),                      // ����
				p_box.get("ENO_NO_SHR").replaceAll("-", ""),                      // �ǰ���ڻ��
				p_box.get("ENO_NOH").replaceAll("-", ""),                         // �����
				p_box.get("EVA_SEQ").replaceAll("-", ""),                         // ����
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK040_SAV(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���κ�����Ȳ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK040_SAV");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVAYM" ))
		        ,JSPUtil.rns(vo.get("EMPNOH" ))
		        ,JSPUtil.rns(vo.get("EMPNO" ))
		        ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("DEPTCD" ))
		        ,JSPUtil.rns(vo.get("DEPTNM" ))
		        ,JSPUtil.rns(vo.get("PAYGRD" ))
		};

		/** CREATE�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);
	}

	public void VLUK040_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���κ�����Ȳ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK040_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVAYM" ))
		        ,JSPUtil.rns(vo.get("EMPNOH" ))
		        ,JSPUtil.rns(vo.get("EMPNO" ))
		        ,JSPUtil.rns(vo.get("EVASEQ" ))
		};

		/** CREATE�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);
	}

}
