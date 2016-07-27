/*
 * Copyright (C) 2007 Erik Swenson - erik@oreports.com
 * 
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place - Suite 330, Boston, MA 02111-1307, USA.
 *  
 */
package top.wetofu.reburnbi.delivery;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import top.wetofu.reburnbi.ReportConstants.ExportType;
import top.wetofu.reburnbi.engine.output.JasperReportEngineOutput;
import top.wetofu.reburnbi.engine.output.ReportEngineOutput;
import top.wetofu.reburnbi.objects.DeliveredReport;
import top.wetofu.reburnbi.objects.MailMessage;
import top.wetofu.reburnbi.objects.ReportSchedule;
import top.wetofu.reburnbi.objects.ReportUser;
import top.wetofu.reburnbi.providers.MailProvider;
import top.wetofu.reburnbi.providers.ProviderException;
import top.wetofu.reburnbi.util.ByteArrayDataSource;


public class EMailDeliveryMethod implements DeliveryMethod 
{
    protected static Logger log = Logger.getLogger(EMailDeliveryMethod.class.getName());
    
    private MailProvider mailProvider;
    
    public void deliverReport(ReportSchedule reportSchedule, ReportEngineOutput reportOutput) throws DeliveryException 
    {
        ArrayList<ByteArrayDataSource> htmlImageDataSources = new ArrayList<ByteArrayDataSource>();
        
        ByteArrayDataSource byteArrayDataSource = exportReport(reportOutput, reportSchedule, htmlImageDataSources);

        MailMessage mail = new MailMessage();               
        mail.setByteArrayDataSource(byteArrayDataSource);
        mail.addHtmlImageDataSources(htmlImageDataSources);          
        mail.setSender(reportSchedule.getUser().getEmail());
        mail.parseRecipients(reportSchedule.getRecipients());
        mail.setBounceAddress(reportSchedule.getDeliveryReturnAddress());
        
        if (reportSchedule.getScheduleDescription() != null && reportSchedule.getScheduleDescription().trim().length() > 0)
        {
            mail.setSubject(reportSchedule.getScheduleDescription());
        }
        else
        {
            mail.setSubject(reportSchedule.getReport().getName());
        }
        
        if (reportSchedule.getExportType() != ExportType.HTML.getCode())
        {
            mail.setText(reportSchedule.getReport().getName() + ": Generated on " + new Date());
        }

        try
        {
            mailProvider.sendMail(mail);
        }
        catch(ProviderException pe)
        {
            throw new DeliveryException(pe);
        }
        
        log.debug(byteArrayDataSource.getName() + " sent to: " + mail.formatRecipients(";"));        
    }
    
    public byte[] getDeliveredReport(DeliveredReport deliveredReport) throws DeliveryException 
    {        
        throw new DeliveryException("Method getDeliveredReport not implemented by EMailDeliveryMethod");
    }

    public DeliveredReport[] getDeliveredReports(ReportUser user) throws DeliveryException 
    {        
        throw new DeliveryException("Method getDeliveredReports not implemented by EMailDeliveryMethod");
    }
    
    protected ByteArrayDataSource exportReport(ReportEngineOutput reportOutput, ReportSchedule reportSchedule,
            ArrayList<ByteArrayDataSource> htmlImageDataSources)
    {       
        String reportName = StringUtils.deleteWhitespace(reportSchedule.getReport().getName());

        ByteArrayDataSource byteArrayDataSource = new ByteArrayDataSource(reportOutput.getContent(), reportOutput.getContentType());
        byteArrayDataSource.setName(reportName + reportOutput.getContentExtension());
        
        if (reportSchedule.getExportType() == ExportType.HTML.getCode()
                && reportSchedule.getReport().isJasperReport())
        {
            Map imagesMap = ((JasperReportEngineOutput) reportOutput).getImagesMap();

            for (Iterator entryIter = imagesMap.entrySet().iterator(); entryIter
                    .hasNext();)
            {
                Map.Entry entry = (Map.Entry) entryIter.next();

                ByteArrayDataSource imageDataSource = new ByteArrayDataSource(
                        (byte[]) entry.getValue(), getImageContentType((byte[]) entry
                                .getValue()));

                imageDataSource.setName((String) entry.getKey());

                htmlImageDataSources.add(imageDataSource);
            }
        }

        return byteArrayDataSource;
    }
    
    /**
     * Try to figure out the image type from its bytes.
     */
    private String getImageContentType(byte[] bytes)
    {
        String header = new String(bytes, 0, (bytes.length > 100) ? 100 : bytes.length);
        if (header.startsWith("GIF"))
        {
            return "image/gif";
        }

        if (header.startsWith("BM"))
        {
            return "image/bmp";
        }

        if (header.indexOf("JFIF") >= 0)
        {
            return "image/jpeg";
        }

        if (header.indexOf("PNG") >= 0)
        {
            return "image/png";
        }

        // We are out of guesses, so just guess tiff
        return "image/tiff";
    }
    
    public void setMailProvider(MailProvider mailProvider) 
    {
        this.mailProvider = mailProvider;
    }   
}
