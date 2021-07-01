<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-- BODY footer begin-->	
						  </td>
						</tr>
					</table>
		<!-- BODY END -->
		</td>
	</tr>
</table>
<%
/*=============================================================================
			Status Bar Falsh
=============================================================================*/
	String dirPath = request.getContextPath();
%>	
	<iframe id="LowerFrame" 
			name="work" 
			style="visibility:hidden; position:absolute; left:280px; top:220px;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
			width="320px" 
			height="42px">
	</iframe>	
</body>
</html>
<!-- BODY footer end-->
