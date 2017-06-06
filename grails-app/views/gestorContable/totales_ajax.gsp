<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 05/05/17
  Time: 11:47
--%>
<table class="table table-bordered table-hover table-condensed">
    <tr style="border-collapse: collapse; border: solid; border-color: #ADB2B3; border-width: 2px">
        <td style="width: 270px">TOTALES:</td>
        <td style="background-color: ${(baseD==baseH)?'#d0ffd0':'#ffd0d0'}; width: 80px" >${baseD}</td>
        <td style="background-color: ${(sinD==sinH)?'#d0ffd0':'#ffd0d0'}; width: 80px" >${sinD}</td>
        <td style="background-color: ${(impD==impH)?'#d0ffd0':'#ffd0d0'}; width: 80px">${impD}</td>
        <td style="background-color: ${(valorD==valorH)?'#d0ffd0':'#ffd0d0'}; width: 90px">${valorD}</td>
        <td style="background-color: ${(baseD==baseH)?'#d0ffd0':'#ffd0d0'}; width: 80px; border-left-color: #5d6263; border-left-width: 2px">${baseH}</td>
        <td style="background-color: ${(sinD==sinH)?'#d0ffd0':'#ffd0d0'}; width: 80px;">${sinH}</td>
        <td style="background-color: ${(impD==impH)?'#d0ffd0':'#ffd0d0'}; width: 80px">${impH}</td>
        <td style="background-color: ${(valorD==valorH)?'#d0ffd0':'#ffd0d0'}; width: 80px">${valorH}</td>
        <td style="width: 70px"></td>
    </tr>
</table>