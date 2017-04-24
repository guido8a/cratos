package cratos

import com.lowagie.text.*
import com.lowagie.text.pdf.PdfPCell
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfWriter

import java.awt.*

class Reportes4Controller {

    def reportesPdfService
    def kerberosoldService


    def balanceGeneralAux () {

        println("params" + params)


        def baos = new ByteArrayOutputStream()
        def name = "balanceGeneralAuxiliares_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font fontInfo = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);
        def prmsCellHead2 = [border: Color.WHITE,
                             align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellHead4 = [border: Color.WHITE,
                             align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 4]

        Document document
        document = new Document(PageSize.A4);
//        document.setMargins(56.2, 56.2, 50, 28.1);
        // margins: left, right, top, bottom
        // 1 in = 72, 1cm=28.1, 3cm = 86.4
        def pdfw = PdfWriter.getInstance(document, baos);



        document.open();
        document.addTitle("Reporte de " + "Balance General con Auxiliares" + " " + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema Cratos");
        document.addKeywords("reporte, cratos," + "Balance General con Auxiliares");
        document.addAuthor("Cratos");
        document.addCreator("Tedein SA");
        Paragraph preface = new Paragraph();
        reportesPdfService.addEmptyLine(preface, 1);
        preface.add(new Paragraph("Reporte de " + "Balance General con Auxiliares", fontTitulo));
        preface.add(new Paragraph("Generado por el usuario: " + session.usuario.nombre + " " + session.usuario.apellido + "   el: " + new Date().format("dd/MM/yyyy hh:mm"), fontInfo))
        reportesPdfService.addEmptyLine(preface, 1);
        document.add(preface);

        //

        def empresa = Empresa.get(params.emp)
        def periodo = Periodo.get(params.per)

        def sp = kerberosoldService.ejecutarProcedure("saldos", periodo.contabilidadId)

        Paragraph headers = new Paragraph();
        addEmptyLine(headers, 1);
        headers.setAlignment(Element.ALIGN_CENTER);
        headers.add(new Paragraph(empresa.nombre, fontTitulo));
        addEmptyLine(headers, 1);
        headers.add(new Paragraph("ESTADO DE SITUACION FINANCIERA (BALANCE GENERAL CON AUXILIARES)", fontTitulo));
        addEmptyLine(headers, 1);
        headers.add(new Paragraph("Movimiento desde: " + periodo.fechaInicio.format("dd-MM-yyyy") + "  hasta: " + periodo.fechaFin.format("dd-MM-yyyy"), fontTitulo))
        headers.add(new Paragraph(" ", fontInfo))

        PdfPTable tablaCuentas = new PdfPTable(3);
        tablaCuentas.setWidthPercentage(100);

        Cuenta.findAllByEmpresaAndNivel(empresa, Nivel.get(1)).each { cuenta ->
            getCuentas(tablaCuentas, cuenta, periodo)
        }

        document.add(headers);
        document.add(tablaCuentas);
        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)


    }


    def getCuentas(tablaCuentas, cuenta, periodo){

        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font fontInfo = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);
        def prmsCellHead2 = [border: Color.WHITE,
                             align : Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsCellHead3 = [border: Color.WHITE,
                             align : Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]

        addCellTabla(tablaCuentas, new Paragraph(cuenta?.numero, fontInfo), prmsCellHead2)
        addCellTabla(tablaCuentas, new Paragraph(cuenta?.descripcion, fontInfo), prmsCellHead2)
//        addCellTabla(tablaCuentas, new Paragraph(cuenta?.nivel?.descripcion, fontInfo), prmsCellHead2)

        def saldos = SaldoMensual.findAllByCuentaAndPeriodo(cuenta, periodo)
        def saldoInit = 0

        saldos.each {
            it.refresh()
            saldoInit += (it.saldoInicial + it.debe - it.haber)
        }


        addCellTabla(tablaCuentas, new Paragraph(g.formatNumber(number: saldoInit, minFractionDigits:2, maxFractionDigits: 2, format: "##,##0", locale: "ec"), fontInfo), prmsCellHead3)

        if(cuenta.movimiento == '0'){

            Cuenta.findAllByPadre(cuenta).each { cuentaHija ->
                getCuentas(tablaCuentas, cuentaHija, periodo)
            }

        }else {

            Asiento.findAllByCuenta(cuenta).each { asiento ->

                if(asiento.comprobante.proceso.proveedor){

                    if(asiento.comprobante.proceso.proveedor.nombre){

                        addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)
                        addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)
                        addCellTabla(tablaCuentas, new Paragraph(asiento?.comprobante?.proceso?.proveedor?.nombre, fontInfo), prmsCellHead2)


                    } else if ( asiento?.comprobante?.proceso?.proveedor?.nombreContacto){

                        addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)
                        addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)
                        addCellTabla(tablaCuentas, new Paragraph(asiento?.comprobante?.proceso?.proveedor?.nombreContacto, fontInfo), prmsCellHead2)


                    }else {

                        addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)
                        addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)
                        addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)


                    }



                }else {
                    addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)
                    addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)
                    addCellTabla(tablaCuentas, new Paragraph(" ", fontInfo), prmsCellHead2)



                }


                addCellTabla(tablaCuentas, new Paragraph(g.formatNumber(number: asiento.debe - asiento.haber , minFractionDigits:
                        2, maxFractionDigits: 2, format: "##,##0", locale: "ec"), fontInfo), prmsCellHead2)




            }

            return tablaCuentas

        }







    }


    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }


    }


    def addCellTabla(table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);
        cell.setBorderColor(Color.BLACK);
        if (params.border) {
            if (!params.bordeBot)
                if (!params.bordeTop)
                    cell.setBorderColor(params.border);
        }
        if (params.bg) {
            cell.setBackgroundColor(params.bg);
        }
        if (params.colspan) {
            cell.setColspan(params.colspan);
        }
        if (params.align) {
            cell.setHorizontalAlignment(params.align);
        }
        if (params.valign) {
            cell.setVerticalAlignment(params.valign);
        }
        if (params.w) {
            cell.setBorderWidth(params.w);
        }
        if (params.bordeTop) {
            cell.setBorderWidthTop(1)
            cell.setBorderWidthLeft(0)
            cell.setBorderWidthRight(0)
            cell.setBorderWidthBottom(0)
            cell.setPaddingTop(7);

        }
        if (params.bordeBot) {
            cell.setBorderWidthBottom(1)
            cell.setBorderWidthLeft(0)
            cell.setBorderWidthRight(0)
            cell.setPaddingBottom(7)

            if (!params.bordeTop) {
                cell.setBorderWidthTop(0)
            }
        }

        table.addCell(cell);
    }


}
