package Ehr.edu.h.eduh032.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUH032DAO extends AbstractDAO {
	public EDUH032DAO(String p_dsId, TrBox p_tr) throws CException {
		super(p_dsId, p_tr);
	}

    /**
     * ������������ SELECT�� �����ϴ� DAO �޼ҵ�
     * @param p_box
     * @throws CException
     */
    public void EDUH032_SHR(CBox p_box) throws CException {
        String sql      = XmlSqlUtils.getSQL("edu", "EDUH032_SHR");

        Object[] bind = new Object[] {
                p_box.get("EDU_CD"),                                        // �����ڵ�
                p_box.get("SEQ_NO")                                       // ������
        };

        this.selectProcessFirstRow(sql, bind, prop);
    }

    /**
     * ������ ������ ������ �´�.
     * @param p_box
     * @throws CException
     */

    public void EDUH032_SHR_NEW(CBox p_box) throws CException {
    	String sql     = XmlSqlUtils.getSQL("edu", "EDUH032_SHR_NEW");

    	Object[] bind = new Object[] {
    			p_box.get("EDU_CD")

        };

    	this.selectProcessFirstRow(sql, bind, prop);
    }

    /**
     * ���ο� ���� ��ȣ�� ������ �´�.
     * @param p_box
     * @throws CException
     */
    public void EDUH032_SHR_CHASU(CBox p_box) throws CException {
        String sql      = XmlSqlUtils.getSQL("edu", "EDUH032_SHR_CHASU");

        Object[] bind = new Object[] {
                p_box.get("EDU_CD"),                                        // �����ڵ�
                p_box.get("EDU_CD"),                                        // �����ڵ�
        };
        prop.add("MAX_CHASU", ColumnProp.COLUMN_TYPE_STRING , 11, ColumnProp.CONSTRAINT_TB_NORMAL);
        //System.out.print(p_box);
        this.selectProcessFirstRow(sql, bind, prop);
    }

	/**
	 * ������������ INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUH032_INS(GauceValueObject vo, CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUH032_INS");


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

                p_box.get("SESSION_ENONO"),                                     // �Է���
                p_box.get("SESSION_ENONO"),                                      // ������
		};

        insertProcess(sql, bind);
	}

	/**
	 * ������������ UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUH032_UPT(GauceValueObject vo, CBox p_box) throws CException {
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

	/**
	 * ������������ DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUH032_DEL(GauceValueObject vo, CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUH032_DEL");

		Object[] bind = new Object[] {
				vo.get("EDU_CD"),                                       // �����ڵ�
				vo.get("SEQ_NO"),                                        // SEQ��ȣ

		};

		deleteProcess(sql, bind);
	}
}
