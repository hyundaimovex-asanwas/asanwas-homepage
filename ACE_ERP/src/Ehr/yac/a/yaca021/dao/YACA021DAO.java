package Ehr.yac.a.yaca021.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA021DAO extends AbstractDAO {
    private GauceDataSet ds;

	/**
	 * INSB021DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA021DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * �ξ簡�� ������ �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }

    
    /**
     * 2013�⵵ �ξ簡�� ������ �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_13(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_13");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    /**
     * 2014�⵵ �ξ簡�� ������ �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("ENO_NO")        		
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * 2014�⵵ �ξ簡�� ������ �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("ENO_NO")        		
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }     
    
    /**
     * 2015�⵵ �ξ簡�� ������ �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("ENO_NO")        		
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        
        System.out.println("YACA021_SHR_15::"+Query);

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }     
    
    
    /**
     * �ξ簡�� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_INFO(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_INFO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }

    /**
     * �ξ簡�� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_INFO_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_INFO_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    /**
     * �ξ簡�� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_INFO_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_INFO_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * �ξ簡�� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_INFO_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_INFO_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    
    
    /**
     * ���ΰ� �����������Ա� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_PER(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_PER");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);   
		prop.add("AMOUNT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);     
		prop.add("INT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    		
        
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    /**
     * ���ΰ� �����������Ա� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_PER_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_PER_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);   
		prop.add("AMOUNT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);     
		prop.add("INT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    		
        
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    /**
     * ���ΰ� �����������Ա� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_PER_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_PER_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);   
		prop.add("AMOUNT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);     
		prop.add("INT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    		
        
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * ���ΰ� �����������Ա� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_PER_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_PER_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);   
		prop.add("AMOUNT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);     
		prop.add("INT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    		
        
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * ������� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_RENT(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_RENT");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    
        
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    /**
     * ������� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_RENT_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_RENT_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    
        
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    /**
     * ������� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_RENT_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_RENT_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    
        
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }      
    
    /**
     * ������� �� ���� ��������
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_RENT_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_RENT_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    
        
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }      
    
    /**
     * �ξ簡�� ������ ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_INS(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_INS");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("REL_CD")
                ,vo.get("NAM_KOR")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("RCH_MAN")							//6������
                ,vo.get("CHI_MAN")							//���ڳ��߰�����
                ,vo.get("INP_MAN")  							//����Ծ����
                ,vo.get("ONE_PARENT")  					//�Ѻθ����                
                
                ,vo.get("LIN_AMT_NTS")					//�����
                ,vo.get("LIH_AMT_NTS")					//��������뺸���
                ,vo.get("MED_AMT_NTS")					//�Ƿ��   
                ,vo.get("LEN_AMT_NTS")					//�÷º����Ƿ��
                ,vo.get("EDU_AMT_NTS")					//������ 
                ,vo.get("HED_AMT_NTS")					//�����Ư��������
                ,vo.get("CARD_AMT_NTS")				//�ſ�ī��  
                ,vo.get("DIR_CARD_AMT_NTS")			//����üũī�����
                ,vo.get("CASH_AMT_NTS")				//���ݿ�����  
                ,vo.get("MARKET_AMT_NTS")             //�������
                ,vo.get("PUBLIC_AMT_NTS")				//���߱����̿�
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")
                
                ,vo.get("LH1_AMT")    					//�����ڱ�_������
                ,vo.get("LH2_AMT04")					//��������������ھ�(10~15��)
                ,vo.get("LH2_AMT")						//��������������ھ�(15���̻�)
                ,vo.get("LH4_AMT")						//��������������ھ�(30���̻�)
                ,vo.get("LH5_AMT")						//���ΰ� �������������ݻ�ȯ��
                ,vo.get("LH6_AMT")						//������
                ,vo.get("LH7_AMT")						//2012�� ���� �����ݸ�/���ġ
                ,vo.get("LH8_AMT")                		//2012�� ���� ��Ÿ����
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT04_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")                

                ,SES_ENO_NO
                ,SES_ENO_NO
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }
    
    
    
    
    
    /**
     * �ξ簡�� ������ ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_INS_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_INS_14");

        //System.out.println("p_box1   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());        
        //String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("REL_CD")
                ,vo.get("NAM_KOR")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  						//�Ѻθ����                
                
                ,vo.get("LIN_AMT_NTS")					//�����
                ,vo.get("LIH_AMT_NTS")					//��������뺸���
                ,vo.get("MED_AMT_NTS")					//�Ƿ��   
                ,vo.get("LEN_AMT_NTS")					//�÷º����Ƿ��
                ,vo.get("EDU_AMT_NTS")					//������ 
                ,vo.get("HED_AMT_NTS")					//�����Ư��������
                ,vo.get("CARD_AMT_NTS")					//�ſ�ī��  
                ,vo.get("DIR_CARD_AMT_NTS")			//����üũī�����
                ,vo.get("CASH_AMT_NTS")					//���ݿ�����  
                ,vo.get("MARKET_AMT_NTS")             //�������
                ,vo.get("PUBLIC_AMT_NTS")				//���߱����̿�
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//            

                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")
                
                ,vo.get("LH1_AMT")    					//�����ڱ�_������
                ,vo.get("LH2_AMT")						//���ΰ� �������������ݻ�ȯ��
                ,vo.get("LH3_AMT")						//��������������ھ�(10~15��)
                ,vo.get("LH4_AMT")						//��������������ھ�(15~29��)
                ,vo.get("LH5_AMT")						//��������������ھ�(30���̻�)
                ,vo.get("LH6_AMT")						//������
                ,vo.get("LH7_AMT")						//2012�� ���� �����ݸ�/���ġ
                ,vo.get("LH8_AMT")                		//2012�� ���� ��Ÿ����
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")                

                ,vo.get("SAJU_AMT_NTS")
                ,vo.get("SAJU_AMT")                  
                
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")                

        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }

    /**
     * �ξ簡�� ������ ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_INS_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_INS_142");

        //System.out.println("p_box1   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());        
        //String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("REL_CD")
                ,vo.get("NAM_KOR")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  						//�Ѻθ����                
                
                ,vo.get("LIN_AMT_NTS")					//�����
                ,vo.get("LIH_AMT_NTS")					//��������뺸���
                ,vo.get("MED_AMT_NTS")					//�Ƿ��   
                ,vo.get("LEN_AMT_NTS")					//�÷º����Ƿ��
                ,vo.get("EDU_AMT_NTS")					//������ 
                ,vo.get("HED_AMT_NTS")					//�����Ư��������
                ,vo.get("CARD_AMT_NTS")					//�ſ�ī��  
                ,vo.get("DIR_CARD_AMT_NTS")			//����üũī�����
                ,vo.get("CASH_AMT_NTS")					//���ݿ�����  
                ,vo.get("MARKET_AMT_NTS")             //�������
                ,vo.get("PUBLIC_AMT_NTS")				//���߱����̿�
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//            

                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")
                
                ,vo.get("LH1_AMT")    					//�����ڱ�_������
                ,vo.get("LH2_AMT")						//���ΰ� �������������ݻ�ȯ��
                ,vo.get("LH3_AMT")						//��������������ھ�(10~15��)
                ,vo.get("LH4_AMT")						//��������������ھ�(15~29��)
                ,vo.get("LH5_AMT")						//��������������ھ�(30���̻�)
                ,vo.get("LH6_AMT")						//������
                ,vo.get("LH7_AMT")						//2012�� ���� �����ݸ�/���ġ
                ,vo.get("LH8_AMT")                		//2012�� ���� ��Ÿ����
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")                

                ,vo.get("SAJU_AMT_NTS")
                ,vo.get("SAJU_AMT")                  
                
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")                

        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }
    
    
    /**
     * �ξ簡�� ������ ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_INS_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_INS_15");

        //System.out.println("p_box1   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());        
        //String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("REL_CD")
                ,vo.get("NAM_KOR")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  					//�Ѻθ����              
                ,vo.get("INP_MAN")  					//             
                ,vo.get("RCH_MAN")  					//             
                
                ,vo.get("LIN_AMT_NTS")					//�����
                ,vo.get("LIH_AMT_NTS")					//��������뺸���
                ,vo.get("MED_AMT_NTS")					//�Ƿ��   
                ,vo.get("LEN_AMT_NTS")					//�÷º����Ƿ��
                ,vo.get("EDU_AMT_NTS")					//������ 
                ,vo.get("HED_AMT_NTS")					//�����Ư��������
                ,vo.get("CARD_AMT_NTS")					//�ſ�ī��  
                ,vo.get("DIR_CARD_AMT_NTS")			    //����üũī�����
                ,vo.get("CASH_AMT_NTS")					//���ݿ�����  
                ,vo.get("MARKET_AMT_NTS")               //�������
                ,vo.get("PUBLIC_AMT_NTS")				//���߱����̿�
                
                ,vo.get("CARD_2013_AMT")				//���� 2013�⵵ �ſ�ī��� ����
                ,vo.get("CARD_2014_AMT")				//���� 2014�⵵ �ſ�ī��� ����  
                ,vo.get("CARD_2013_OVER")             	//���� 2013�⵵ �߰������� ����
                ,vo.get("CARD_2014_OVER")				//���� 2014�⵵ �߰������� ����  
                ,vo.get("CARD_2015_AMT")                //���� 2015�⵵ �ſ�ī��� ����
                ,vo.get("CARD_2015_FH_OVER")            //���� 2015�⵵ ��ݱ� �߰������� ����  
                ,vo.get("CARD_2015_SH_OVER")            //���� 2015�⵵ �Ϲݱ� �߰������� ���� 

                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")
                
                ,vo.get("LH1_AMT")    					//�����ڱ�_������
                ,vo.get("LH2_AMT")						//���ΰ� �������������ݻ�ȯ��
                ,vo.get("LH3_AMT")						//��������������ھ�(10~15��)
                ,vo.get("LH4_AMT")						//��������������ھ�(15~29��)
                ,vo.get("LH5_AMT")						//��������������ھ�(30���̻�)
                ,vo.get("LH6_AMT")						//������
                ,vo.get("LH7_AMT")						//2012�� ���� �����ݸ�/���ġ
                ,vo.get("LH8_AMT")                		//2012�� ���� ��Ÿ����
                ,vo.get("LH9_AMT")                		//2015�� 15���̻� ���� �׸��� ���ġ
                ,vo.get("LH10_AMT")                		//2015�� 15���̻� ���� �Ǵ� ���ġ
                ,vo.get("LH11_AMT")                		//2015�� 15���̻� �Ϲݴ���
                ,vo.get("LH12_AMT")                		//2015�� 10~14�� ���� �Ǵ� ���ġ
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")  
                ,vo.get("LH9_AMT_NTS")  
                ,vo.get("LH10_AMT_NTS")  
                ,vo.get("LH11_AMT_NTS")  
                ,vo.get("LH12_AMT_NTS")  

                ,vo.get("SAJU_AMT_NTS")
                ,vo.get("SAJU_AMT")                  
                
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")                

        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }
    
    
    /**
     * �ξ簡�� ������ �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")

                ,vo.get("ONE_PARENT")  	                         
                
                ,vo.get("LIN_AMT_NTS")
                ,vo.get("LIH_AMT_NTS")
                ,vo.get("MED_AMT_NTS")
                ,vo.get("LEN_AMT_NTS")
                ,vo.get("EDU_AMT_NTS")
                ,vo.get("HED_AMT_NTS")
                ,vo.get("CARD_AMT_NTS")
                ,vo.get("DIR_CARD_AMT_NTS")
                ,vo.get("CASH_AMT_NTS")
                ,vo.get("MARKET_AMT_NTS")                
                ,vo.get("PUBLIC_AMT_NTS")
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")      
                
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT04")
                ,vo.get("LH2_AMT")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")              
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT04_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")            
                
                ,vo.get("HOL_YN")
                ,p_box.get("vusrid")              
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }

    
    /**
     * �ξ簡�� ������ �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_14(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_14");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
        		
                 vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  	                         
                
                ,vo.get("LIN_AMT_NTS")
                ,vo.get("LIH_AMT_NTS")
                ,vo.get("MED_AMT_NTS")
                ,vo.get("LEN_AMT_NTS")
                ,vo.get("EDU_AMT_NTS")
                ,vo.get("HED_AMT_NTS")
                
                ,vo.get("CARD_AMT_NTS")
                ,vo.get("DIR_CARD_AMT_NTS")
                ,vo.get("CASH_AMT_NTS")
                ,vo.get("MARKET_AMT_NTS")                
                ,vo.get("PUBLIC_AMT_NTS")
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")      
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//  
                
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT")
                ,vo.get("LH3_AMT")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")              
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")            
                
                ,vo.get("SAJU_AMT_NTS")                
                ,vo.get("SAJU_AMT")
                
                ,vo.get("HOL_YN")
                ,p_box.get("vusrid")              
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }    
    
    /**
     * �ξ簡�� ������ �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_142(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_142");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
        		
                 vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  	                         
                
                ,vo.get("LIN_AMT_NTS")
                ,vo.get("LIH_AMT_NTS")
                ,vo.get("MED_AMT_NTS")
                ,vo.get("LEN_AMT_NTS")
                ,vo.get("EDU_AMT_NTS")
                ,vo.get("HED_AMT_NTS")
                
                ,vo.get("CARD_AMT_NTS")
                ,vo.get("DIR_CARD_AMT_NTS")
                ,vo.get("CASH_AMT_NTS")
                ,vo.get("MARKET_AMT_NTS")                
                ,vo.get("PUBLIC_AMT_NTS")
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")      
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//  
                
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT")
                ,vo.get("LH3_AMT")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")              
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")            
                
                ,vo.get("SAJU_AMT_NTS")                
                ,vo.get("SAJU_AMT")
                
                ,vo.get("HOL_YN")
                ,p_box.get("vusrid")              
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }    
       
    /**
     * �ξ簡�� ������ �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_15(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_15");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
        		
                 vo.get("BAS_MAN")  //�⺻����
                ,vo.get("GOL_70")   //��ο�����
                ,vo.get("TRB_MAN")  //����ΰ���
                ,vo.get("INV_MAN")  //��ֿ���              
                ,vo.get("WCT_MAN")  //�γ��ڰ���
                ,vo.get("ONE_MAN")  //�Ѻθ����
                ,vo.get("INP_MAN")  //����Ծ� �߰�
                ,vo.get("RCH_MAN")  //6������ �߰�
                
                ,vo.get("LIN_AMT_NTS")
                ,vo.get("LIH_AMT_NTS")
                ,vo.get("MED_AMT_NTS")
                ,vo.get("LEN_AMT_NTS")
                ,vo.get("EDU_AMT_NTS")
                ,vo.get("HED_AMT_NTS")
                
                ,vo.get("CARD_AMT_NTS")
                ,vo.get("DIR_CARD_AMT_NTS")
                ,vo.get("CASH_AMT_NTS")
                ,vo.get("MARKET_AMT_NTS")                
                ,vo.get("PUBLIC_AMT_NTS")
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")      
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//  
                ,vo.get("CARD_2015_AMT")				//  
                ,vo.get("CARD_2015_FH_OVER")    		//  
                ,vo.get("CARD_2015_SH_OVER")			//  
                
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT")
                ,vo.get("LH3_AMT")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")      
                ,vo.get("LH9_AMT")     
                ,vo.get("LH10_AMT")     
                ,vo.get("LH11_AMT")     
                ,vo.get("LH12_AMT")     
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")
                ,vo.get("LH9_AMT_NTS")
                ,vo.get("LH10_AMT_NTS")
                ,vo.get("LH11_AMT_NTS")
                ,vo.get("LH12_AMT_NTS")
                
                ,vo.get("SAJU_AMT_NTS")                
                ,vo.get("SAJU_AMT")
                
                ,vo.get("HOL_YN")
                ,vo.get("INS_TAG")
                ,p_box.get("vusrid")              
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }    
    
    
    /**
     * �ξ簡�� ���� ����
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_DEL(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_DEL");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 vo.get("PIS_YY")
                ,vo.get("ENO_NO")
                ,vo.get("CET_NO").replaceAll("-", "")
        };

        //�� ������ DataSet ��������
        this.deleteProcess(Query, bind);
    }

    
    /**
     * �ξ簡�� ���� ����
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_DEL_14(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_DEL_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 vo.get("PIS_YY")
                ,vo.get("ENO_NO")
                ,vo.get("CET_NO").replaceAll("-", "")
        };

        //�� ������ DataSet ��������
        this.deleteProcess(Query, bind);
    }    
    
    /**
     * �ξ簡�� ���� ����
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_DEL_142(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_DEL_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 vo.get("PIS_YY")
                ,vo.get("ENO_NO")
                ,vo.get("CET_NO").replaceAll("-", "")
        };

        //�� ������ DataSet ��������
        this.deleteProcess(Query, bind);
    }       
    
    /**
     * �ξ簡�� ���� ����
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_DEL_15(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_DEL_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 vo.get("PIS_YY")
                ,vo.get("ENO_NO")
                ,vo.get("CET_NO").replaceAll("-", "")
        };

        //�� ������ DataSet ��������
        this.deleteProcess(Query, bind);
    }       
    
    
    /**
     * ������ �׸� ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_RENT(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_RENT");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("HOST_NM")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD").replaceAll("-", "")
                ,vo.get("DUE_YMD").replaceAll("-", "")             
                ,p_box.get("vusrid") 
                ,p_box.get("vusrid") 
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }
    

    /**
     * ������ �׸� ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_RENT_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_RENT_14");
        
        
		//System.out.print("p_boxYACA021_SAV_RENT_14================= "+p_box);
		//System.out.print("vo================= "+vo);		
		
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.getString("HOST_NM")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.getString("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD").replaceAll("-", "")
                ,vo.get("DUE_YMD").replaceAll("-", "")             
                ,p_box.get("vusrid") 
                ,p_box.get("vusrid") 
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }    
    
    /**
     * ������ �׸� ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_RENT_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_RENT_142");
        
        
		//System.out.print("p_boxYACA021_SAV_RENT_14================= "+p_box);
		//System.out.print("vo================= "+vo);		
		
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.getString("HOST_NM")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.getString("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD").replaceAll("-", "")
                ,vo.get("DUE_YMD").replaceAll("-", "")             
                ,p_box.get("vusrid") 
                ,p_box.get("vusrid") 
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * ������ �׸� ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_RENT_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_RENT_15");
        
        
		System.out.print("p_boxYACA021_SAV_RENT_15================= "+p_box);
		System.out.print("vo================= "+vo);		
		
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.getString("HOST_NM")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.getString("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD").replaceAll("-", "")
                ,vo.get("DUE_YMD").replaceAll("-", "")   
                ,vo.get("HOUSE_TYPE")
                ,vo.get("HOUSE_AREA")
                ,p_box.get("vusrid") 
                ,p_box.get("vusrid") 
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * ������ �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_RENT(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_RENT");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
        		
                 vo.getString("HOST_NM")
                ,vo.get("CET_NO")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD")
                ,vo.get("DUE_YMD")     
                ,p_box.get("vusrid")                 
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
    
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }    
    
    /**
     * ������ �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_RENT_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_RENT_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
        		
                 vo.get("HOST_NM")
                ,vo.get("CET_NO")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD")
                ,vo.get("DUE_YMD")     
                ,p_box.get("vusrid")                 
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
    
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * ������ �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_RENT_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_RENT_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
        		
                 vo.get("HOST_NM")
                ,vo.get("CET_NO")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD")
                ,vo.get("DUE_YMD")     
                ,p_box.get("vusrid")                 
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
    
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }      
    
    /**
     * ������ �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_RENT_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_RENT_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
        		
                 vo.get("HOST_NM")
                ,vo.get("CET_NO")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD")
                ,vo.get("DUE_YMD")
                ,vo.get("HOUSE_TYPE")
                ,vo.get("HOUSE_AREA")
                ,p_box.get("vusrid")                 
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
    
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }      
    
    
    /**
     * T_AC_FAMILY �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM2(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM2");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
               vo.get("AMOUNT")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }      
    
    /**
     * T_AC_FAMILY �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM2_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM2_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
               vo.get("AMOUNT")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }      
        
    /**
     * T_AC_FAMILY �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM2_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM2_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
               vo.get("AMOUNT")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }  
    
    /**
     * T_AC_FAMILY �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM2_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM2_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
               vo.get("AMOUNT")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }  
    
    /**
     * ���ΰ� �����������Ա� �׸� ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_PER(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_PER");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
               ,vo.get("HOST_NM")
               ,vo.get("CET_NO").replaceAll("-", "")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD").replaceAll("-", "")
               ,vo.get("DUE_YMD").replaceAll("-", "")         
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")                    
               ,p_box.get("vusrid") 
               ,p_box.get("vusrid") 
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }

    
    /**
     * ���ΰ� �����������Ա� �׸� ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_PER_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_PER_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
               ,vo.get("HOST_NM")
               ,vo.get("CET_NO").replaceAll("-", "")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD").replaceAll("-", "")
               ,vo.get("DUE_YMD").replaceAll("-", "")         
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")                    
               ,p_box.get("vusrid") 
               ,p_box.get("vusrid") 
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }

    /**
     * ���ΰ� �����������Ա� �׸� ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_PER_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_PER_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
               ,vo.get("HOST_NM")
               ,vo.get("CET_NO").replaceAll("-", "")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD").replaceAll("-", "")
               ,vo.get("DUE_YMD").replaceAll("-", "")         
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")                    
               ,p_box.get("vusrid") 
               ,p_box.get("vusrid") 
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }    
    
    /**
     * ���ΰ� �����������Ա� �׸� ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_PER_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_PER_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
               ,vo.get("HOST_NM")
               ,vo.get("CET_NO").replaceAll("-", "")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD").replaceAll("-", "")
               ,vo.get("DUE_YMD").replaceAll("-", "")  
               ,vo.get("HOUSE_TYPE")
               ,vo.get("HOUSE_AREA")
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")                    
               ,p_box.get("vusrid") 
               ,p_box.get("vusrid") 
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }    
    
    
    
    
    /**
     * ���ΰ� �����������Ա� �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_PER(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PER");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                vo.get("HOST_NM")
               ,vo.get("CET_NO")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD")
               ,vo.get("DUE_YMD")     
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }    
    
    
    /**
     * ���ΰ� �����������Ա� �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_PER_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PER_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                vo.get("HOST_NM")
               ,vo.get("CET_NO")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD")
               ,vo.get("DUE_YMD")     
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }        
    
    /**
     * ���ΰ� �����������Ա� �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_PER_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PER_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                vo.get("HOST_NM")
               ,vo.get("CET_NO")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD")
               ,vo.get("DUE_YMD")     
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * ���ΰ� �����������Ա� �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_PER_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PER_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                vo.get("HOST_NM")
               ,vo.get("CET_NO")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD")
               ,vo.get("DUE_YMD") 
               ,vo.get("HOUSE_TYPE")
               ,vo.get("HOUSE_AREA")
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * T_AC_FAMILY �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
               vo.get("AMOUNT2")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }      
    
    
    /**
     * T_AC_FAMILY �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
               vo.get("AMOUNT2")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }      
        
    /**
     * T_AC_FAMILY �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
               vo.get("AMOUNT2")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }  
    
    
    /**
     * T_AC_FAMILY �׸� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
               vo.get("AMOUNT2")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }  
    
    /**
     * ���� ���� ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_CNT(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_CNT");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�� ������ DataSet ��������
        return this.selectProcessGvo(Query, bind);
    }
    
    /**
     * ���� ���� ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_CNT_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_CNT_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�� ������ DataSet ��������
        return this.selectProcessGvo(Query, bind);
    }
    
    /**
     * ���� ���� ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_CNT_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_CNT_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�� ������ DataSet ��������
        return this.selectProcessGvo(Query, bind);
    }    
    
    /**
     * ���� ���� ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_CNT_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_CNT_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�� ������ DataSet ��������
        return this.selectProcessGvo(Query, bind);
    }    
    
    

    /**
     * ���� ���� ��ü ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_ALL(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_ALL");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�� ������ DataSet ��������
        return this.selectProcessGvo(Query, bind);
    }

    /**
     * ���� ���� ��ü ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_ALL_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_ALL_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�� ������ DataSet ��������
        return this.selectProcessGvo(Query, bind);
    }    
    
    /**
     * ���� ���� ��ü ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_ALL_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_ALL_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�� ������ DataSet ��������
        return this.selectProcessGvo(Query, bind);
    }      
    
    
    /**
     * ���� ���� ��ü ��ȸ
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_ALL_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_ALL_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�� ������ DataSet ��������
        return this.selectProcessGvo(Query, bind);
    }      
    
    
    /**
     * �ξ簡�� ������ ���� �� ������ ���� ���̺� �����Ѵ�.
     * @param p_box
     * @throws CException
     */
    public void YACA021_UPT_ACC(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_ACC");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                
                ,p_box.get("LIN_AMT")
                ,p_box.get("LIH_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("LF2_AMT")
                
                ,p_box.get("LEN_AMT")
                ,p_box.get("LEN_AMT2")
                ,p_box.get("LEN_AMT3")
                ,p_box.get("LEN_AMT4")
                ,p_box.get("LEN_AMT5")
                ,p_box.get("EDU_TAG1")
                ,p_box.get("EDU_AMT1")
                ,p_box.get("EDU_TAG2")
                ,p_box.get("EDU_AMT2")
                ,p_box.get("EDU_TAG3")
                ,p_box.get("EDU_AMT3")
                ,p_box.get("EDU_TAG4")
                ,p_box.get("EDU_AMT4")
                ,p_box.get("EDU_TAG5")
                ,p_box.get("EDU_AMT5")
                
                ,p_box.get("GRA_AMT")
                ,p_box.get("HED_AMT")
                
                ,p_box.get("CARD_AMT")
                ,p_box.get("DIR_CARD_AMT")
                ,p_box.get("CASH_AMT")
                ,p_box.get("MARKET_AMT")    
                ,p_box.get("PUBLIC_AMT")
                
                ,p_box.get("LC1_AMT")   //��α�
                ,p_box.get("LC2_AMT")
                ,p_box.get("LC3_AMT")
                ,p_box.get("LC4_AMT")
                
                ,p_box.get("LH1_AMT")   //�����ڱ�
                ,p_box.get("LH2_AMT04")
                ,p_box.get("LH2_AMT")
                ,p_box.get("LH4_AMT")
                ,p_box.get("LH5_AMT")
                ,p_box.get("LH6_AMT")
                ,p_box.get("LH7_AMT")
                ,p_box.get("LH8_AMT")            
                
                ,p_box.get("HOL_YN")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�����ϱ�
        this.updateProcess(Query, bind);
    }

    
    /**
     * �ξ簡�� ������ ���� �� ������ ���� ���̺� �����Ѵ�.
     * @param p_box
     * @throws CException
     */
    public void YACA021_UPT_ACC_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_ACC_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                
                ,p_box.get("LIN_AMT")
                ,p_box.get("LIH_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")

                
                ,p_box.get("LEN_AMT")
                ,p_box.get("LEN_AMT2")
                ,p_box.get("LEN_AMT3")
                ,p_box.get("LEN_AMT4")
                ,p_box.get("LEN_AMT5")
                ,p_box.get("EDU_TAG1")
                ,p_box.get("EDU_AMT1")
                ,p_box.get("EDU_TAG2")
                ,p_box.get("EDU_AMT2")
                ,p_box.get("EDU_TAG3")
                ,p_box.get("EDU_AMT3")
                ,p_box.get("EDU_TAG4")
                ,p_box.get("EDU_AMT4")
                ,p_box.get("EDU_TAG5")
                ,p_box.get("EDU_AMT5")
                
                ,p_box.get("GRA_AMT")
                ,p_box.get("HED_AMT")
                
                ,p_box.get("CARD_AMT")
                ,p_box.get("DIR_CARD_AMT")
                ,p_box.get("CASH_AMT")
                ,p_box.get("MARKET_AMT")    
                ,p_box.get("PUBLIC_AMT")
                
                ,p_box.get("CARD_2013_AMT")
                ,p_box.get("CARD_2014_AMT")
                ,p_box.get("CARD_2013_OVER")
                ,p_box.get("CARD_2014_OVER")    

                ,p_box.get("LC1_AMT")   //��α�
                ,p_box.get("LC2_AMT")
                ,p_box.get("LC3_AMT")
                
                ,p_box.get("LH1_AMT")   //�����ڱ�
                ,p_box.get("LH2_AMT")
                ,p_box.get("LH3_AMT")
                ,p_box.get("LH4_AMT")
                ,p_box.get("LH5_AMT")
                ,p_box.get("LH6_AMT")
                ,p_box.get("LH7_AMT")
                ,p_box.get("LH8_AMT")            
                
                ,p_box.get("SAJU_AMT")     
                
                ,p_box.get("HOL_YN")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�����ϱ�
        this.updateProcess(Query, bind);
    }    
    
    /**
     * �ξ簡�� ������ ���� �� ������ ���� ���̺� �����Ѵ�.
     * @param p_box
     * @throws CException
     */
    public void YACA021_UPT_ACC_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_ACC_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                
                ,p_box.get("LIN_AMT")
                ,p_box.get("LIH_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")

                
                ,p_box.get("LEN_AMT")
                ,p_box.get("LEN_AMT2")
                ,p_box.get("LEN_AMT3")
                ,p_box.get("LEN_AMT4")
                ,p_box.get("LEN_AMT5")
                ,p_box.get("EDU_TAG1")
                ,p_box.get("EDU_AMT1")
                ,p_box.get("EDU_TAG2")
                ,p_box.get("EDU_AMT2")
                ,p_box.get("EDU_TAG3")
                ,p_box.get("EDU_AMT3")
                ,p_box.get("EDU_TAG4")
                ,p_box.get("EDU_AMT4")
                ,p_box.get("EDU_TAG5")
                ,p_box.get("EDU_AMT5")
                
                ,p_box.get("GRA_AMT")
                ,p_box.get("HED_AMT")
                
                ,p_box.get("CARD_AMT")
                ,p_box.get("DIR_CARD_AMT")
                ,p_box.get("CASH_AMT")
                ,p_box.get("MARKET_AMT")    
                ,p_box.get("PUBLIC_AMT")
                
                ,p_box.get("CARD_2013_AMT")
                ,p_box.get("CARD_2014_AMT")
                ,p_box.get("CARD_2013_OVER")
                ,p_box.get("CARD_2014_OVER")    

                ,p_box.get("LC1_AMT")   //��α�
                ,p_box.get("LC2_AMT")
                ,p_box.get("LC3_AMT")
                
                ,p_box.get("LH1_AMT")   //�����ڱ�
                ,p_box.get("LH2_AMT")
                ,p_box.get("LH3_AMT")
                ,p_box.get("LH4_AMT")
                ,p_box.get("LH5_AMT")
                ,p_box.get("LH6_AMT")
                ,p_box.get("LH7_AMT")
                ,p_box.get("LH8_AMT")            
                
                ,p_box.get("SAJU_AMT")     
                
                ,p_box.get("HOL_YN")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�����ϱ�
        this.updateProcess(Query, bind);
    }    
    
    
    public void YACA021_UPT_ACC_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_ACC_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                ,p_box.get("INP_CNT")
                ,p_box.get("RCH_CNT")
                
                ,p_box.get("LIN_AMT")
                ,p_box.get("LIH_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")

                
                ,p_box.get("LEN_AMT")
                ,p_box.get("LEN_AMT2")
                ,p_box.get("LEN_AMT3")
                ,p_box.get("LEN_AMT4")
                ,p_box.get("LEN_AMT5")
                ,p_box.get("EDU_TAG1")
                ,p_box.get("EDU_AMT1")
                ,p_box.get("EDU_TAG2")
                ,p_box.get("EDU_AMT2")
                ,p_box.get("EDU_TAG3")
                ,p_box.get("EDU_AMT3")
                ,p_box.get("EDU_TAG4")
                ,p_box.get("EDU_AMT4")
                ,p_box.get("EDU_TAG5")
                ,p_box.get("EDU_AMT5")
                
                ,p_box.get("GRA_AMT")
                ,p_box.get("HED_AMT")
                
                ,p_box.get("CARD_AMT")
                ,p_box.get("DIR_CARD_AMT")
                ,p_box.get("CASH_AMT")
                ,p_box.get("MARKET_AMT")    
                ,p_box.get("PUBLIC_AMT")
                
                ,p_box.get("CARD_2013_AMT")
                ,p_box.get("CARD_2014_AMT")
                ,p_box.get("CARD_2013_OVER")
                ,p_box.get("CARD_2014_OVER")  
                ,p_box.get("CARD_2015_AMT")  
                ,p_box.get("CARD_2015_FH_OVER")  
                ,p_box.get("CARD_2015_SH_OVER")  

                ,p_box.get("LC1_AMT")   //��α�
                ,p_box.get("LC2_AMT")
                ,p_box.get("LC3_AMT")
                
                ,p_box.get("LH1_AMT")   //�����ڱ�
                ,p_box.get("LH2_AMT")
                ,p_box.get("LH3_AMT")
                ,p_box.get("LH4_AMT")
                ,p_box.get("LH5_AMT")
                ,p_box.get("LH6_AMT")
                ,p_box.get("LH7_AMT")
                ,p_box.get("LH8_AMT")    
                ,p_box.get("LH9_AMT")    
                ,p_box.get("LH10_AMT")    
                ,p_box.get("LH11_AMT")    
                ,p_box.get("LH12_AMT")    
                
                ,p_box.get("SAJU_AMT")     
                
                ,p_box.get("HOL_YN")
                ,p_box.get("INS_TAG")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //�����ϱ�
        this.updateProcess(Query, bind);
    }    
     
     
    
    
    
    /**
     * �ξ� ���� ������ ����� ������ �λ� �����Ϳ� �����Ѵ�.
     * @param p_box
     * @throws CException
     */
    public void YACA021_UPT_PERSON(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PERSON");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                ,p_box.get("CHI_CNT")
                ,p_box.get("ENO_NO")
        };

        //�����ϱ�
        this.updateProcess(Query, bind);
    }
}
