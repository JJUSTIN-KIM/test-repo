<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>

p {
	font-size:50px;
	color:#FFA5C3;
	align-content:center;	
}

.table_basic th{
	text-align:center;
}

</style>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<div id="div_form">
	<hr width="30%" size="1" color="#d1d1d1" />
	<p align="center">MemberShip</p>
	<hr width="30%" size="1" color="#d1d1d1" />
	
            <table class="table_basic" align="center" cellpadding="1" cellspacing="1">
                <colgroup>
                    <col width="10%">
                    <col width="18%">
                    <col width="18%">
                    <col width="18%">
                    <col width="18%">
                    <col width="18%">
                </colgroup>
                    <tr class="col" align="center" >
                        <th scope="col">회원 등급</th>
                        <th scope="col"><img src="images/mem_level1.jpg"><br><br>NORMAL(일반회원)</th>
                        <th scope="col"><img src="images/mem_level2.jpg"><br><br>SILVER(실버회원)</th>
                        <th scope="col"><img src="images/mem_level3.jpg"><br><br>GOLD(골드회원)</th>
                        <th scope="col"><img src="images/mem_level4.jpg"><br><br>VIP(VIP회원)</th>
                        <th scope="col"><img src="images/mem_level5.jpg"><br><br>MASTER(Master회원)</th>
                    </tr>	
                    <tr bordercolor="red" >
                        <th scope="row">누적 구매 금액</th>
                        <td>신규 회원~150,000원 미만</td>
                        <td>150,000~300,000원 미만</td>
                        <td>300,000~500,000원 미만</td>
                        <td>500,000~1,000,000원 미만</td>
                        <td>1,000,000원 이상</td>
                    </tr>
                    <tr>
                        <th scope="row">회원 혜택</th>
               			<td class="vertical_middle" align="center">
               			<br /><br />- 구매 금액 적립 10%</td>
						<td><img src="images/mem_dis2.jpg"><br>-  멤버십 추가 할인 3%<br>- 구매 금액 적립 10%</td>
						<td><img src="images/mem_dis3.jpg"><br>-  멤버십 추가 할인 5%<br>- 구매 금액 적립 10%</td>
						<td><img src="images/mem_dis4.jpg"><br>-  멤버십 추가 할인 7%<br>- 구매 금액 적립 10%</td>
						<td><img src="images/mem_dis5.jpg"><br>-  멤버십 추가 할인 10%<br>- 구매 금액 적립 10%</td>

             </tr>
</table>
</div>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>