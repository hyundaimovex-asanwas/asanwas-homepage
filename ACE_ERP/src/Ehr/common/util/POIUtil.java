/*
 * POIUtil
 *
 * Version 1.0
 *
 * Date 2007-06-12
 *
 * Copyright
 *
 * Description POI Package �� ���õ� �Լ��� ����
 */

package Ehr.common.util;

import java.math.BigDecimal;

import org.apache.poi.hssf.usermodel.HSSFRow;

import com.shift.gef.core.log.Log;

public class POIUtil {

    /**
     * �ش� �÷��� ���� String ���� ��ȯ�� �´�.
     * @param poiRow        - row Object
     * @param currentCell   - �ش� column �� index
     * @return
     */
    public static String getString(HSSFRow poiRow, int currentCell) {
        String result = null;
        try {
            int cellType = poiRow.getCell((short) currentCell).getCellType();

            // CellType is
            //0: Numericc
            if(cellType == 0) {
                result = String.valueOf(new BigDecimal(poiRow.getCell((short) currentCell).getNumericCellValue()).toBigInteger());
            }
            //1: String
            else if(cellType == 1) {
                result = poiRow.getCell((short) currentCell).getStringCellValue();
            }
            //2: Formula
            else if(cellType == 2) {
                System.out.println(poiRow.getCell((short) currentCell).getCellFormula());
            }
            //3: Blank
            else if(cellType == 3) {
                result = "";
            }
            //4: Boolean
            else if(cellType == 4) {
                result = new Boolean(poiRow.getCell((short) currentCell).getBooleanCellValue()).toString();
            }
            //5: Error
            else {
                result = "";
            }
        }
        //���� ����ְų�(null) ������ ����
        catch (Exception e) {
            result = "";
        }

       // Log.sys.println(currentCell+":"+result);
        return result.trim();
    }

    /**
     * �������� ���� int ������ �����´�.
     * @param poiRow
     * @param currentCell
     * @return
     */
    public static int getInt(HSSFRow poiRow, int currentCell) {
        int result = 0;

        try {
            result = new Integer(getString(poiRow, currentCell)).intValue();
        } catch(Exception e) {
            result = 0;
        }

        return result;
    }

    /**
     * �������� ���� long ������ �����´�.
     * @param poiRow
     * @param currentCell
     * @return
     */
    public static long getLong(HSSFRow poiRow, int currentCell) {
        long result = 0;

        try {
            result = new Long(getString(poiRow, currentCell)).longValue();
        } catch(Exception e) {
            result = 0;
        }

        return result;
    }

    /**
     * �������� ���� double ������ �����´�.
     * @param poiRow
     * @param currentCell
     * @return
     */
    public static double getDouble(HSSFRow poiRow, int currentCell) {
        double result = 0;

        try {
            result = new Double(getString(poiRow, currentCell)).doubleValue();
        } catch(Exception e) {
            result = 0;
        }

        return result;
    }

    /**
     * ���ڿ��� ��¥ ���·� ��ȯ�ؼ� ��ȯ
     * @param poiRow
     * @param currentCell
     * @param format
     * @return
     */
    public static String getDateString(HSSFRow poiRow, int currentCell, String format) {
        if(format == null || format.equals(""))
            format = "yyyy-MM-dd";

        String result = "";
        String cellVal = "";
        try {
            cellVal = getString(poiRow, currentCell);

            if(cellVal != null && !cellVal.equals(""))
                result = DateUtil.getConvertDateFormat(cellVal, format);
        } catch(Exception e) {
            result = "";
        }

        return result;
    }
}
