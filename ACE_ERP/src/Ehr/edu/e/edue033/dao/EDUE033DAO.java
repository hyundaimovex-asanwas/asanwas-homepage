package Ehr.edu.e.edue033.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE033DAO extends AbstractDAO {
	/**
	 * EDUE032DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE033DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
     * ������������ SELECT�� �����ϴ� DAO �޼ҵ�
     * @param p_box
     * @throws CException
     */
    public void EDUE033_SHR(CBox p_box) throws CException {
        String sql      = XmlSqlUtils.getSQL("edu", "EDUE033_SHR");

        Object[] bind = new Object[] {
                p_box.get("EDU_CD")                                        // �����ڵ�
        };

        this.selectProcessFirstRow(sql, bind, prop);
    }

    /**
     * ������ ������ ������ �´�.
     * @param p_box
     * @throws CException
     */

    public void EDUE033_SHR_NEW(CBox p_box) throws CException {
    	String sql     = XmlSqlUtils.getSQL("edu", "EDUE033_SHR_NEW");

    	Object[] bind = new Object[] {
    			p_box.get("EDU_CD")

        };

    	this.selectProcessFirstRow(sql, bind, prop);
    }

	/**
	 * ������������ INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE033_INS(GauceValueObject vo, CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUE033_INS");


        Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("EDU_CD")),                                  // �����ڵ�
                JSPUtil.rns(vo.get("EDU_CD")),                                  // ����(�ڵ����)
                JSPUtil.rns(vo.get("EDU_NM")),                                 // ������
                JSPUtil.rns(vo.get("CET_NO")),                                  // �����ֹι�ȣ
                JSPUtil.rns(vo.get("INS_YN")),                                  // ��뺸��
                JSPUtil.rns(vo.get("PLACE_TAG")),                               // �������
                JSPUtil.rns(vo.get("ENT_STR_YMD")).replaceAll("-", ""),         // ��û��������
                JSPUtil.rns(vo.get("ENT_END_YMD")).replaceAll("-", ""),         // ��û��������
                JSPUtil.rns(vo.get("EDU_STR_YMD")).replaceAll("-", ""),         // �н���������
                JSPUtil.rns(vo.get("EDU_END_YMD")).replaceAll("-", ""),         // �н���������

                JSPUtil.rns(vo.get("EDU_GBN_CD")),                              // ��������
                JSPUtil.rns(vo.get("MNGER_CD")),                                // �����ְ�
                JSPUtil.rns(vo.get("FIELD_CD")),                                // �����о�
                JSPUtil.rns(vo.get("SHAPE_CD")),                                // ��������
                JSPUtil.rns(vo.get("GOAL_TAG")),                                // ������ǥ

                JSPUtil.rns(vo.get("CONTENT_TXT")),                             // ��������
                JSPUtil.rns(vo.get("EFFECT_TAG")),                              // ���ȿ��
                JSPUtil.rns(vo.get("OBJ_TAG")),                                 // �������
                JSPUtil.rns(vo.get("CPT_TAG")),                                 // �������

                JSPUtil.rns(vo.get("INT_NAM")),                                 // �������
                JSPUtil.rns(vo.get("FIX_NO")),                                  // ��������
                JSPUtil.rns(vo.get("DAY_NO")),                                  // �����ϼ�
                JSPUtil.rns(vo.get("TIME_NO")),                                 // �����ð�
                JSPUtil.rns(vo.get("COST_AMT")),                                // �������
                JSPUtil.rns(vo.get("COST_CD")),                                 // ���δ�
                JSPUtil.rns(vo.get("RTN_AMT")),                                 // ȯ�ޱݾ�
                JSPUtil.rns(vo.get("PLACE_CD")),                                // �������
                JSPUtil.rns(vo.get("CPT_PNT")),                                 // �̼�����
                JSPUtil.rns(vo.get("SITE_TAG")),                                // �������Ʈ

                //p_box.get("SESSION_ENONO"),                                     // �Է���
                //p_box.get("SESSION_ENONO"),                                     // ������
                p_box.get("vusrid"), //�Է���
                p_box.get("vusrid")  //������
		};

        insertProcess(sql, bind);
	}

	/**
	 * ������������ UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE033_UPT(GauceValueObject vo, CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUH032_UPT");

		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("EDU_NM")),                                 // ������
                JSPUtil.rns(vo.get("CET_NO")),                                  // �����ֹι�ȣ
                JSPUtil.rns(vo.get("INS_YN")),                                  // ��뺸��
                JSPUtil.rns(vo.get("PLACE_TAG")),                               // �������
                JSPUtil.rns(vo.get("ENT_STR_YMD")).replaceAll("-", ""),         // ��û��������
                JSPUtil.rns(vo.get("ENT_END_YMD")).replaceAll("-", ""),         // ��û��������
                JSPUtil.rns(vo.get("EDU_STR_YMD")).replaceAll("-", ""),         // �н���������
                JSPUtil.rns(vo.get("EDU_END_YMD")).replaceAll("-", ""),         // �н���������

                JSPUtil.rns(vo.get("EDU_GBN_CD")),                              // ��������
                JSPUtil.rns(vo.get("MNGER_CD")),                                // �����ְ�
                JSPUtil.rns(vo.get("FIELD_CD")),                                // �����о�
                JSPUtil.rns(vo.get("SHAPE_CD")),                                // ��������
                JSPUtil.rns(vo.get("GOAL_TAG")),                                // ������ǥ

                JSPUtil.rns(vo.get("CONTENT_TXT")),                             // ��������
                JSPUtil.rns(vo.get("EFFECT_TAG")),                              // ���ȿ��
                JSPUtil.rns(vo.get("OBJ_TAG")),                                 // �������
                JSPUtil.rns(vo.get("CPT_TAG")),                                 // �������

                JSPUtil.rns(vo.get("INT_NAM")),                                 // �������
                JSPUtil.rns(vo.get("FIX_NO")),                                  // ��������
                JSPUtil.rns(vo.get("DAY_NO")),                                  // �����ϼ�
                JSPUtil.rns(vo.get("TIME_NO")),                                 // �����ð�
                JSPUtil.rns(vo.get("COST_AMT")),                                // �������
                JSPUtil.rns(vo.get("COST_CD")),                                 // ���δ�
                JSPUtil.rns(vo.get("RTN_AMT")),                                 // ȯ�ޱݾ�
                JSPUtil.rns(vo.get("PLACE_CD")),                                // �������
                JSPUtil.rns(vo.get("CPT_PNT")),                                 // �̼�����
                JSPUtil.rns(vo.get("SITE_TAG")),                                // �������Ʈ

				p_box.get("SESSION_ENONO"),                                     // ������
                JSPUtil.rns(vo.get("EDU_CD")),                                  // �����ڵ�
                JSPUtil.rns(vo.get("SEQ_NO")),                                  // ���� SEQ
              //  vo.get("COMM_NO")                                               // ���й�ȣ
		};

		updateProcess(sql, bind);
	}
}
