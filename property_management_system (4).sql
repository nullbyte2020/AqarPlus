-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 16, 2025 at 10:20 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `property_management_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `title_ar` varchar(500) DEFAULT NULL,
  `content` text NOT NULL,
  `content_ar` text DEFAULT NULL,
  `announcement_type` enum('general','maintenance','policy','emergency','event') DEFAULT 'general',
  `target_audience` enum('all','tenants','owners','staff','specific_property') DEFAULT 'all',
  `target_property_id` int(11) DEFAULT NULL,
  `priority` enum('low','normal','high','urgent') DEFAULT 'normal',
  `is_pinned` tinyint(1) DEFAULT 0,
  `send_notification` tinyint(1) DEFAULT 1,
  `send_email` tinyint(1) DEFAULT 0,
  `send_sms` tinyint(1) DEFAULT 0,
  `attachment_paths` text DEFAULT NULL COMMENT 'JSON array of file paths',
  `published_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `status` enum('draft','published','expired','archived') DEFAULT 'draft',
  `view_count` int(11) DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `title_ar`, `content`, `content_ar`, `announcement_type`, `target_audience`, `target_property_id`, `priority`, `is_pinned`, `send_notification`, `send_email`, `send_sms`, `attachment_paths`, `published_at`, `expires_at`, `status`, `view_count`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Monthly Maintenance Schedule', 'جدول الصيانة الشهرية', 'Dear residents, please note that routine maintenance will be conducted on all properties during the first week of each month. We will provide 48-hour advance notice for any unit-specific work.', 'عزيزي المقيمين، يرجى ملاحظة أن الصيانة الدورية ستتم في جميع العقارات خلال الأسبوع الأول من كل شهر. سنقوم بتقديم إشعار مسبق بـ 48 ساعة لأي عمل خاص بالوحدة.', 'maintenance', 'tenants', NULL, 'normal', 1, 1, 0, 0, NULL, '2025-01-01 06:00:00', '2025-12-31 21:59:59', 'published', 0, 2, '2025-07-14 13:43:56', '2025-07-14 13:43:56'),
(2, 'New Security Measures', 'إجراءات أمنية جديدة', 'We are implementing enhanced security measures across all properties including upgraded CCTV systems and additional security personnel during evening hours.', 'نحن نطبق إجراءات أمنية معززة في جميع العقارات بما في ذلك أنظمة المراقبة المحدثة وموظفي أمن إضافيين خلال ساعات المساء.', 'general', 'all', NULL, 'high', 1, 1, 0, 0, NULL, '2025-01-15 07:00:00', '2025-02-15 21:59:59', 'published', 0, 1, '2025-07-14 13:43:56', '2025-07-14 13:43:56'),
(3, 'Rent Payment Policy Update', 'تحديث سياسة دفع الإيجار', 'Effective March 1st, 2025, all rent payments can be made through our new online portal. Traditional payment methods remain available.', 'اعتباراً من 1 مارس 2025، يمكن دفع جميع الإيجارات من خلال بوابتنا الإلكترونية الجديدة. طرق الدفع التقليدية تبقى متاحة.', 'policy', 'tenants', NULL, 'normal', 0, 1, 0, 0, NULL, '2025-02-15 08:00:00', '2025-03-31 21:59:59', 'published', 0, 3, '2025-07-14 13:43:56', '2025-07-14 13:43:56');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `expense_number` varchar(100) DEFAULT NULL,
  `property_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `expense_category` varchar(100) NOT NULL,
  `expense_subcategory` varchar(100) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `expense_date` date NOT NULL,
  `payment_method` enum('cash','bank_transfer','check','credit_card') DEFAULT NULL,
  `reference_number` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `description_ar` text DEFAULT NULL,
  `receipt_path` varchar(255) DEFAULT NULL,
  `is_recurring` tinyint(1) DEFAULT 0,
  `recurring_frequency` enum('monthly','quarterly','semi_annual','annual') DEFAULT NULL,
  `status` enum('pending','approved','paid','cancelled') DEFAULT 'pending',
  `approved_by` int(11) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `expense_number`, `property_id`, `unit_id`, `expense_category`, `expense_subcategory`, `vendor_id`, `amount`, `tax_amount`, `expense_date`, `payment_method`, `reference_number`, `description`, `description_ar`, `receipt_path`, `is_recurring`, `recurring_frequency`, `status`, `approved_by`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'EXP2025001', 1, NULL, 'Utilities', 'Electricity', NULL, 850.00, 127.50, '2025-01-31', 'bank_transfer', NULL, 'Monthly electricity bill for Al-Nakheel Complex', 'فاتورة الكهرباء الشهرية لمجمع النخيل', NULL, 0, NULL, 'paid', 3, 3, '2025-07-14 13:44:26', '2025-07-14 13:44:26'),
(2, 'EXP2025002', 2, NULL, 'Maintenance', 'Cleaning', 3, 400.00, 60.00, '2025-02-01', 'cash', NULL, 'Monthly cleaning service for Business Center Plaza', 'خدمة التنظيف الشهرية لبلازا المركز التجاري', NULL, 0, NULL, 'paid', 2, 2, '2025-07-14 13:44:26', '2025-07-14 13:44:26'),
(3, 'EXP2025003', 1, 2, 'Maintenance', 'Plumbing', 1, 150.00, 22.50, '2025-01-15', 'check', NULL, 'Kitchen sink repair - Unit A102', 'إصلاح حوض المطبخ - الوحدة A102', NULL, 0, NULL, 'paid', 2, 6, '2025-07-14 13:44:26', '2025-07-14 13:44:26'),
(4, 'EXP2025004', 3, NULL, 'Insurance', 'Property Insurance', NULL, 2400.00, 360.00, '2025-01-01', 'bank_transfer', NULL, 'Annual property insurance premium', 'قسط التأمين السنوي على العقار', NULL, 0, NULL, 'paid', 4, 3, '2025-07-14 13:44:26', '2025-07-14 13:44:26'),
(5, 'EXP2025005', 4, NULL, 'Security', 'Security Services', NULL, 1800.00, 270.00, '2025-02-01', 'bank_transfer', NULL, 'Monthly security services fee', 'رسوم الخدمات الأمنية الشهرية', NULL, 0, NULL, 'approved', 3, 2, '2025-07-14 13:44:26', '2025-07-14 13:44:26');

-- --------------------------------------------------------

--
-- Table structure for table `file_uploads`
--

CREATE TABLE `file_uploads` (
  `id` int(11) NOT NULL,
  `entity_type` varchar(50) NOT NULL COMMENT 'property, tenant, lease, etc.',
  `entity_id` int(11) NOT NULL,
  `file_category` varchar(50) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `stored_filename` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` int(11) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `file_hash` varchar(64) NOT NULL,
  `is_public` tinyint(1) DEFAULT 0,
  `uploaded_by` int(11) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `file_uploads`
--

INSERT INTO `file_uploads` (`id`, `entity_type`, `entity_id`, `file_category`, `original_filename`, `stored_filename`, `file_path`, `file_size`, `mime_type`, `file_hash`, `is_public`, `uploaded_by`, `upload_date`) VALUES
(1, 'property', 1, 'image', 'al_nakheel_exterior.jpg', 'prop_1_ext_20250101_001.jpg', 'uploads/properties/1/images/prop_1_ext_20250101_001.jpg', 2048576, 'image/jpeg', 'a1b2c3d4e5f6789012345678901234567890abcd', 1, 2, '2025-07-14 13:44:48'),
(2, 'property', 2, 'document', 'business_center_lease_template.pdf', 'prop_2_doc_20250101_001.pdf', 'uploads/properties/2/documents/prop_2_doc_20250101_001.pdf', 1536000, 'application/pdf', 'b2c3d4e5f6789012345678901234567890abcde', 0, 2, '2025-07-14 13:44:48'),
(3, 'tenant', 1, 'document', 'ahmed_employment_contract.pdf', 'tenant_1_doc_20250102_001.pdf', 'uploads/tenants/1/documents/tenant_1_doc_20250102_001.pdf', 2560000, 'application/pdf', 'c3d4e5f6789012345678901234567890abcdef1', 0, 1, '2025-07-14 13:44:48'),
(4, 'maintenance', 1, 'image', 'kitchen_sink_before.jpg', 'maint_1_img_20250115_001.jpg', 'uploads/maintenance/1/images/maint_1_img_20250115_001.jpg', 1024000, 'image/jpeg', 'd4e5f6789012345678901234567890abcdef12', 0, 1, '2025-07-14 13:44:48'),
(5, 'lease', 1, 'document', 'signed_lease_agreement.pdf', 'lease_1_doc_20250101_001.pdf', 'uploads/leases/1/documents/lease_1_doc_20250101_001.pdf', 3072000, 'application/pdf', 'e5f6789012345678901234567890abcdef123', 0, 2, '2025-07-14 13:44:48');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `invoice_number` varchar(100) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `lease_id` int(11) DEFAULT NULL,
  `invoice_type` enum('rent','utilities','maintenance','other') DEFAULT 'rent',
  `issue_date` date NOT NULL,
  `due_date` date NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `total_amount` decimal(15,2) NOT NULL,
  `amount_paid` decimal(15,2) DEFAULT 0.00,
  `status` enum('draft','sent','paid','overdue','cancelled') DEFAULT 'draft',
  `payment_terms` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `sent_date` date DEFAULT NULL,
  `paid_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `invoice_number`, `tenant_id`, `lease_id`, `invoice_type`, `issue_date`, `due_date`, `subtotal`, `tax_amount`, `discount_amount`, `total_amount`, `amount_paid`, `status`, `payment_terms`, `notes`, `created_by`, `sent_date`, `paid_date`, `created_at`, `updated_at`) VALUES
(1, 'INV2025001', 1, 1, 'rent', '2025-02-25', '2025-03-01', 4500.00, 0.00, 0.00, 4500.00, 0.00, 'sent', NULL, NULL, 3, NULL, NULL, '2025-07-14 13:31:48', '2025-07-14 13:31:48'),
(2, 'INV2025002', 2, 2, 'rent', '2025-02-25', '2025-03-01', 2800.00, 0.00, 0.00, 2800.00, 0.00, 'sent', NULL, NULL, 3, NULL, NULL, '2025-07-14 13:31:48', '2025-07-14 13:31:48'),
(3, 'INV2025003', 3, 3, 'rent', '2025-02-10', '2025-02-15', 8000.00, 0.00, 0.00, 8000.00, 0.00, 'paid', NULL, NULL, 3, NULL, NULL, '2025-07-14 13:31:48', '2025-07-14 13:31:48'),
(4, 'INV2025004', 1, 1, 'utilities', '2025-01-31', '2025-02-15', 150.00, 0.00, 0.00, 150.00, 0.00, 'overdue', NULL, NULL, 3, NULL, NULL, '2025-07-14 13:31:48', '2025-07-14 13:31:48');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `item_description` varchar(255) NOT NULL,
  `item_description_ar` varchar(500) DEFAULT NULL,
  `quantity` decimal(8,2) DEFAULT 1.00,
  `unit_price` decimal(10,2) NOT NULL,
  `line_total` decimal(12,2) NOT NULL,
  `tax_rate` decimal(5,2) DEFAULT 0.00,
  `sort_order` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `invoice_id`, `item_description`, `item_description_ar`, `quantity`, `unit_price`, `line_total`, `tax_rate`, `sort_order`) VALUES
(1, 1, 'Monthly Rent - March 2025', 'إيجار شهر مارس 2025', 1.00, 4500.00, 4500.00, 0.00, 0),
(2, 2, 'Monthly Rent - March 2025', 'إيجار شهر مارس 2025', 1.00, 2800.00, 2800.00, 0.00, 0),
(3, 3, 'Monthly Rent - February 2025', 'إيجار شهر فبراير 2025', 1.00, 8000.00, 8000.00, 0.00, 0),
(4, 4, 'Electricity Bill', 'فاتورة الكهرباء', 1.00, 150.00, 150.00, 0.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `lease_agreements`
--

CREATE TABLE `lease_agreements` (
  `id` int(11) NOT NULL,
  `lease_number` varchar(100) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `rent_amount` decimal(10,2) NOT NULL,
  `security_deposit` decimal(10,2) DEFAULT 0.00,
  `commission_amount` decimal(10,2) DEFAULT 0.00,
  `utilities_included` tinyint(1) DEFAULT 0,
  `payment_frequency` enum('monthly','quarterly','semi_annual','annual') DEFAULT 'monthly',
  `payment_due_day` tinyint(4) DEFAULT 1,
  `late_fee_amount` decimal(10,2) DEFAULT 0.00,
  `late_fee_grace_days` tinyint(4) DEFAULT 5,
  `status` enum('draft','active','terminated','expired','renewed') DEFAULT 'draft',
  `termination_date` date DEFAULT NULL,
  `termination_reason` text DEFAULT NULL,
  `auto_renewal` tinyint(1) DEFAULT 0,
  `renewal_notice_days` tinyint(4) DEFAULT 30,
  `terms_and_conditions` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `signed_date` date DEFAULT NULL,
  `tenant_signed` tinyint(1) DEFAULT 0,
  `landlord_signed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lease_agreements`
--

INSERT INTO `lease_agreements` (`id`, `lease_number`, `tenant_id`, `unit_id`, `start_date`, `end_date`, `rent_amount`, `security_deposit`, `commission_amount`, `utilities_included`, `payment_frequency`, `payment_due_day`, `late_fee_amount`, `late_fee_grace_days`, `status`, `termination_date`, `termination_reason`, `auto_renewal`, `renewal_notice_days`, `terms_and_conditions`, `created_by`, `signed_date`, `tenant_signed`, `landlord_signed`, `created_at`, `updated_at`) VALUES
(1, 'LSE2025001', 1, 2, '2025-01-01', '2025-12-31', 4500.00, 9000.00, 0.00, 0, 'monthly', 1, 0.00, 5, 'active', NULL, NULL, 0, 30, NULL, 2, NULL, 1, 1, '2025-07-14 13:30:56', '2025-07-14 13:30:56'),
(2, 'LSE2025002', 2, 5, '2025-02-01', '2026-01-31', 2800.00, 5600.00, 0.00, 0, 'monthly', 1, 0.00, 5, 'active', NULL, NULL, 0, 30, NULL, 2, NULL, 1, 1, '2025-07-14 13:30:56', '2025-07-14 13:30:56'),
(3, 'LSE2025003', 3, 7, '2025-01-15', '2026-01-14', 8000.00, 16000.00, 0.00, 0, 'monthly', 1, 0.00, 5, 'active', NULL, NULL, 0, 30, NULL, 2, NULL, 1, 1, '2025-07-14 13:30:56', '2025-07-14 13:30:56'),
(4, 'LSE2025004', 5, 1, '2025-03-01', '2026-02-28', 3500.00, 7000.00, 0.00, 0, 'monthly', 1, 0.00, 5, 'draft', NULL, NULL, 0, 30, NULL, 2, NULL, 0, 0, '2025-07-14 13:30:56', '2025-07-14 13:30:56');

--
-- Triggers `lease_agreements`
--
DELIMITER $$
CREATE TRIGGER `update_unit_status_on_lease` AFTER INSERT ON `lease_agreements` FOR EACH ROW BEGIN
    IF NEW.status = 'active' THEN
        UPDATE property_units SET status = 'occupied' WHERE id = NEW.unit_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_lease_dates` BEFORE INSERT ON `lease_agreements` FOR EACH ROW BEGIN
    IF NEW.start_date >= NEW.end_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lease start date must be before end date';
    END IF;
    
    IF NEW.rent_amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rent amount must be greater than zero';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `lease_payments`
--

CREATE TABLE `lease_payments` (
  `id` int(11) NOT NULL,
  `lease_id` int(11) NOT NULL,
  `payment_type` enum('rent','security_deposit','commission','late_fee','utility','other') DEFAULT 'rent',
  `due_date` date NOT NULL,
  `payment_date` date DEFAULT NULL,
  `amount_due` decimal(10,2) NOT NULL,
  `amount_paid` decimal(10,2) DEFAULT 0.00,
  `payment_method` enum('cash','bank_transfer','check','online','credit_card') DEFAULT NULL,
  `transaction_reference` varchar(200) DEFAULT NULL,
  `status` enum('pending','partial','completed','overdue','cancelled') DEFAULT 'pending',
  `late_fee_applied` decimal(8,2) DEFAULT 0.00,
  `payment_notes` text DEFAULT NULL,
  `receipt_number` varchar(100) DEFAULT NULL,
  `processed_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lease_payments`
--

INSERT INTO `lease_payments` (`id`, `lease_id`, `payment_type`, `due_date`, `payment_date`, `amount_due`, `amount_paid`, `payment_method`, `transaction_reference`, `status`, `late_fee_applied`, `payment_notes`, `receipt_number`, `processed_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'rent', '2025-01-01', '2025-01-01', 4500.00, 4500.00, 'bank_transfer', NULL, 'completed', 0.00, NULL, NULL, 3, '2025-07-14 13:31:08', '2025-07-14 13:31:08'),
(2, 1, 'rent', '2025-02-01', '2025-02-01', 4500.00, 4500.00, 'bank_transfer', NULL, 'completed', 0.00, NULL, NULL, 3, '2025-07-14 13:31:08', '2025-07-14 13:31:08'),
(3, 1, 'rent', '2025-03-01', NULL, 4500.00, 0.00, NULL, NULL, 'pending', 0.00, NULL, NULL, NULL, '2025-07-14 13:31:08', '2025-07-14 13:31:08'),
(4, 2, 'security_deposit', '2025-02-01', '2025-02-01', 5600.00, 5600.00, 'cash', NULL, 'completed', 0.00, NULL, NULL, 3, '2025-07-14 13:31:08', '2025-07-14 13:31:08'),
(5, 2, 'rent', '2025-02-01', '2025-02-01', 2800.00, 2800.00, 'bank_transfer', NULL, 'completed', 0.00, NULL, NULL, 3, '2025-07-14 13:31:08', '2025-07-14 13:31:08'),
(6, 2, 'rent', '2025-03-01', NULL, 2800.00, 0.00, NULL, NULL, 'pending', 0.00, NULL, NULL, NULL, '2025-07-14 13:31:08', '2025-07-14 13:31:08'),
(7, 3, 'security_deposit', '2025-01-15', '2025-01-15', 16000.00, 16000.00, 'bank_transfer', NULL, 'completed', 0.00, NULL, NULL, 3, '2025-07-14 13:31:08', '2025-07-14 13:31:08'),
(8, 3, 'rent', '2025-01-15', '2025-01-15', 8000.00, 8000.00, 'bank_transfer', NULL, 'completed', 0.00, NULL, NULL, 3, '2025-07-14 13:31:08', '2025-07-14 13:31:08'),
(9, 3, 'rent', '2025-02-15', '2025-02-15', 8000.00, 8000.00, 'online', NULL, 'completed', 0.00, NULL, NULL, 3, '2025-07-14 13:31:08', '2025-07-14 13:31:08');

-- --------------------------------------------------------

--
-- Table structure for table `lease_renewals`
--

CREATE TABLE `lease_renewals` (
  `id` int(11) NOT NULL,
  `original_lease_id` int(11) NOT NULL,
  `new_lease_id` int(11) DEFAULT NULL,
  `new_start_date` date NOT NULL,
  `new_end_date` date NOT NULL,
  `new_rent_amount` decimal(10,2) NOT NULL,
  `rent_increase_percentage` decimal(5,2) DEFAULT 0.00,
  `new_terms` text DEFAULT NULL,
  `renewal_date` date NOT NULL,
  `status` enum('pending','approved','rejected','completed') DEFAULT 'pending',
  `tenant_acceptance` tinyint(1) DEFAULT NULL,
  `landlord_approval` tinyint(1) DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lease_renewals`
--

INSERT INTO `lease_renewals` (`id`, `original_lease_id`, `new_lease_id`, `new_start_date`, `new_end_date`, `new_rent_amount`, `rent_increase_percentage`, `new_terms`, `renewal_date`, `status`, `tenant_acceptance`, `landlord_approval`, `rejection_reason`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, '2026-01-01', '2026-12-31', 4725.00, 5.00, 'Rent increased by 5% as per market rate. All other terms remain the same.', '2025-10-01', 'pending', NULL, NULL, NULL, 2, '2025-07-14 13:43:30', '2025-07-14 13:43:30'),
(2, 3, NULL, '2026-01-15', '2027-01-14', 8400.00, 5.00, 'Annual 5% increase, extended lease term with same conditions.', '2025-10-15', 'approved', 1, 1, NULL, 2, '2025-07-14 13:43:30', '2025-07-14 13:43:30');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_requests`
--

CREATE TABLE `maintenance_requests` (
  `id` int(11) NOT NULL,
  `request_number` varchar(100) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `request_type` varchar(100) NOT NULL,
  `category` enum('plumbing','electrical','hvac','appliance','structural','cleaning','pest_control','other') NOT NULL,
  `title` varchar(255) NOT NULL,
  `title_ar` varchar(500) DEFAULT NULL,
  `description` text NOT NULL,
  `description_ar` text DEFAULT NULL,
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `status` enum('open','assigned','in_progress','pending_parts','completed','closed','cancelled') DEFAULT 'open',
  `preferred_schedule` text DEFAULT NULL,
  `tenant_available_times` text DEFAULT NULL,
  `permission_to_enter` tinyint(1) DEFAULT 0,
  `estimated_cost` decimal(10,2) DEFAULT NULL,
  `actual_cost` decimal(10,2) DEFAULT NULL,
  `assigned_to` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `tenant_satisfaction` tinyint(4) DEFAULT NULL COMMENT '1-5 rating',
  `photos_before` text DEFAULT NULL COMMENT 'JSON array of photo paths',
  `photos_after` text DEFAULT NULL COMMENT 'JSON array of photo paths',
  `internal_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `maintenance_requests`
--

INSERT INTO `maintenance_requests` (`id`, `request_number`, `tenant_id`, `unit_id`, `property_id`, `request_type`, `category`, `title`, `title_ar`, `description`, `description_ar`, `priority`, `status`, `preferred_schedule`, `tenant_available_times`, `permission_to_enter`, `estimated_cost`, `actual_cost`, `assigned_to`, `vendor_id`, `completion_date`, `tenant_satisfaction`, `photos_before`, `photos_after`, `internal_notes`, `created_at`, `updated_at`) VALUES
(1, 'MNT2025001', 1, 2, 1, 'Repair', 'plumbing', 'Kitchen Sink Leak', 'تسريب حوض المطبخ', 'Water leaking from kitchen sink faucet', 'تسرب المياه من صنبور حوض المطبخ', 'medium', 'assigned', NULL, NULL, 0, NULL, NULL, 6, 1, NULL, NULL, NULL, NULL, NULL, '2025-07-14 13:31:18', '2025-07-14 13:31:18'),
(2, 'MNT2025002', 2, 5, 2, 'Electrical', 'electrical', 'Office Light Not Working', 'الإضاءة المكتبية لا تعمل', 'Ceiling lights in office not functioning', 'إضاءة السقف في المكتب لا تعمل', 'high', 'in_progress', NULL, NULL, 0, NULL, NULL, 6, 2, NULL, NULL, NULL, NULL, NULL, '2025-07-14 13:31:18', '2025-07-14 13:31:18'),
(3, 'MNT2025003', 3, 7, 3, 'HVAC', 'hvac', 'Air Conditioning Issue', 'مشكلة في التكييف', 'AC not cooling properly in villa', 'التكييف لا يبرد بشكل صحيح في الفيلا', 'urgent', 'completed', NULL, NULL, 0, NULL, NULL, 6, 4, NULL, NULL, NULL, NULL, NULL, '2025-07-14 13:31:18', '2025-07-14 13:31:18'),
(4, 'MNT2025004', 1, 2, 1, 'Cleaning', 'cleaning', 'Deep Cleaning Request', 'طلب تنظيف عميق', 'Request for thorough apartment cleaning', 'طلب تنظيف شامل للشقة', 'low', 'open', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-14 13:31:18', '2025-07-14 13:31:18');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_schedules`
--

CREATE TABLE `maintenance_schedules` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `maintenance_type` varchar(100) NOT NULL,
  `maintenance_category` enum('preventive','inspection','cleaning','safety_check','equipment_service') NOT NULL,
  `description` text DEFAULT NULL,
  `description_ar` text DEFAULT NULL,
  `frequency_type` enum('daily','weekly','monthly','quarterly','semi_annual','annual') NOT NULL,
  `frequency_interval` tinyint(4) DEFAULT 1,
  `estimated_duration_hours` decimal(4,1) DEFAULT NULL,
  `estimated_cost` decimal(10,2) DEFAULT NULL,
  `preferred_vendor_id` int(11) DEFAULT NULL,
  `last_performed_date` date DEFAULT NULL,
  `next_due_date` date NOT NULL,
  `advance_notice_days` tinyint(4) DEFAULT 7,
  `is_active` tinyint(1) DEFAULT 1,
  `auto_create_work_order` tinyint(1) DEFAULT 0,
  `priority_level` enum('low','medium','high') DEFAULT 'medium',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `maintenance_schedules`
--

INSERT INTO `maintenance_schedules` (`id`, `property_id`, `unit_id`, `maintenance_type`, `maintenance_category`, `description`, `description_ar`, `frequency_type`, `frequency_interval`, `estimated_duration_hours`, `estimated_cost`, `preferred_vendor_id`, `last_performed_date`, `next_due_date`, `advance_notice_days`, `is_active`, `auto_create_work_order`, `priority_level`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'HVAC System Check', 'preventive', 'Quarterly inspection and maintenance of all HVAC systems', 'فحص وصيانة ربع سنوية لجميع أنظمة التكييف', 'quarterly', 1, 4.0, 800.00, 4, NULL, '2025-04-01', 7, 1, 1, 'medium', 2, '2025-07-14 13:44:17', '2025-07-14 13:44:17'),
(2, 2, NULL, 'Fire Safety Inspection', 'safety_check', 'Annual fire safety system inspection and testing', 'فحص واختبار سنوي لنظام السلامة من الحرائق', 'annual', 1, 6.0, 1200.00, NULL, NULL, '2025-06-01', 14, 1, 0, 'high', 1, '2025-07-14 13:44:17', '2025-07-14 13:44:17'),
(3, 3, 7, 'Garden Maintenance', 'cleaning', 'Monthly garden and landscape maintenance for villa', 'صيانة شهرية للحديقة والمناظر الطبيعية للفيلا', 'monthly', 1, 8.0, 500.00, 3, NULL, '2025-03-01', 3, 1, 1, 'low', 2, '2025-07-14 13:44:17', '2025-07-14 13:44:17'),
(4, 4, NULL, 'Elevator Maintenance', 'equipment_service', 'Bi-annual elevator inspection and servicing', 'فحص وصيانة نصف سنوية للمصاعد', 'semi_annual', 1, 3.0, 600.00, NULL, NULL, '2025-07-01', 10, 1, 0, 'high', 2, '2025-07-14 13:44:17', '2025-07-14 13:44:17');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `thread_id` varchar(100) DEFAULT NULL,
  `sender_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `message_type` enum('general','maintenance','payment','lease','complaint','notice') DEFAULT 'general',
  `priority` enum('low','normal','high','urgent') DEFAULT 'normal',
  `property_id` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `lease_id` int(11) DEFAULT NULL,
  `maintenance_request_id` int(11) DEFAULT NULL,
  `parent_message_id` int(11) DEFAULT NULL,
  `attachment_paths` text DEFAULT NULL COMMENT 'JSON array of file paths',
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL,
  `replied_at` timestamp NULL DEFAULT NULL,
  `is_system_message` tinyint(1) DEFAULT 0,
  `requires_response` tinyint(1) DEFAULT 0,
  `response_deadline` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `thread_id`, `sender_id`, `recipient_id`, `subject`, `message`, `message_type`, `priority`, `property_id`, `unit_id`, `lease_id`, `maintenance_request_id`, `parent_message_id`, `attachment_paths`, `sent_at`, `read_at`, `replied_at`, `is_system_message`, `requires_response`, `response_deadline`) VALUES
(1, 'MSG_THREAD_001', 1, 2, 'Kitchen Sink Issue', 'Hello, I am experiencing a leak in my kitchen sink. Water is dripping from the faucet continuously. Please arrange for repair at your earliest convenience.', 'maintenance', 'high', 1, 2, 1, 1, NULL, NULL, '2025-07-14 13:43:40', NULL, NULL, 0, 1, NULL),
(2, 'MSG_THREAD_001', 2, 1, 'Re: Kitchen Sink Issue', 'Thank you for reporting this issue. I have assigned a maintenance worker and they will contact you within 24 hours to schedule the repair.', 'maintenance', 'normal', 1, 2, 1, 1, NULL, NULL, '2025-07-14 13:43:40', NULL, NULL, 0, 0, NULL),
(3, 'MSG_THREAD_002', 2, 3, 'Monthly Rent Payment Reminder', 'Dear Mohammed, this is a friendly reminder that your rent payment of SAR 8,000 is due on February 15th. Please ensure payment is made on time.', 'payment', 'normal', 3, 7, 3, NULL, NULL, NULL, '2025-07-14 13:43:40', NULL, NULL, 0, 0, NULL),
(4, 'MSG_THREAD_003', 4, 2, 'Property Viewing Request', 'I am interested in viewing the available villa unit V02. Could you please arrange a viewing appointment for this weekend?', 'general', 'normal', 3, 8, NULL, NULL, NULL, NULL, '2025-07-14 13:43:40', NULL, NULL, 0, 1, NULL),
(5, 'MSG_THREAD_003', 2, 4, 'Re: Property Viewing Request', 'Certainly! I can arrange a viewing for Saturday at 2 PM. Please confirm if this time works for you.', 'general', 'normal', 3, 8, NULL, NULL, NULL, NULL, '2025-07-14 13:43:40', NULL, NULL, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `notification_type` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `title_ar` varchar(500) DEFAULT NULL,
  `message` text NOT NULL,
  `message_ar` text DEFAULT NULL,
  `action_url` varchar(500) DEFAULT NULL,
  `action_text` varchar(100) DEFAULT NULL,
  `action_text_ar` varchar(200) DEFAULT NULL,
  `priority` enum('low','normal','high','urgent') DEFAULT 'normal',
  `category` enum('system','payment','maintenance','lease','message','reminder') DEFAULT 'system',
  `related_entity_type` varchar(50) DEFAULT NULL,
  `related_entity_id` int(11) DEFAULT NULL,
  `delivery_method` set('in_app','email','sms','push') DEFAULT 'in_app',
  `sent_via_email` tinyint(1) DEFAULT 0,
  `sent_via_sms` tinyint(1) DEFAULT 0,
  `is_read` tinyint(1) DEFAULT 0,
  `is_dismissed` tinyint(1) DEFAULT 0,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `notification_type`, `title`, `title_ar`, `message`, `message_ar`, `action_url`, `action_text`, `action_text_ar`, `priority`, `category`, `related_entity_type`, `related_entity_id`, `delivery_method`, `sent_via_email`, `sent_via_sms`, `is_read`, `is_dismissed`, `expires_at`, `created_at`, `read_at`) VALUES
(1, 4, 'payment_received', 'Payment Received', 'تم استلام الدفعة', 'Rent payment of SAR 4,500 received from Ahmed Al-Mahmoud', 'تم استلام دفعة إيجار بقيمة 4,500 ريال من أحمد المحمود', NULL, NULL, NULL, 'normal', 'payment', NULL, NULL, 'in_app', 0, 0, 0, 0, NULL, '2025-07-14 13:31:58', NULL),
(2, 2, 'maintenance_request', 'New Maintenance Request', 'طلب صيانة جديد', 'New plumbing repair request submitted for Unit A102', 'تم تقديم طلب إصلاح سباكة جديد للوحدة A102', NULL, NULL, NULL, 'high', 'maintenance', NULL, NULL, 'in_app', 0, 0, 0, 0, NULL, '2025-07-14 13:31:58', NULL),
(3, 6, 'work_order_assigned', 'Work Order Assigned', 'تم تعيين أمر عمل', 'You have been assigned work order WO2025001', 'تم تعيينك لأمر العمل WO2025001', NULL, NULL, NULL, 'normal', 'maintenance', NULL, NULL, 'in_app', 0, 0, 0, 0, NULL, '2025-07-14 13:31:58', NULL),
(4, 1, 'rent_due_reminder', 'Rent Due Reminder', 'تذكير استحقاق الإيجار', 'Your rent payment of SAR 4,500 is due on March 1st', 'دفعة الإيجار البالغة 4,500 ريال مستحقة في 1 مارس', NULL, NULL, NULL, 'high', 'payment', NULL, NULL, 'in_app', 0, 0, 0, 0, NULL, '2025-07-14 13:31:58', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `owner_statements`
--

CREATE TABLE `owner_statements` (
  `id` int(11) NOT NULL,
  `statement_number` varchar(100) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `statement_period_start` date NOT NULL,
  `statement_period_end` date NOT NULL,
  `total_rental_income` decimal(15,2) DEFAULT 0.00,
  `total_other_income` decimal(15,2) DEFAULT 0.00,
  `total_expenses` decimal(15,2) DEFAULT 0.00,
  `management_fee` decimal(15,2) DEFAULT 0.00,
  `net_income` decimal(15,2) DEFAULT 0.00,
  `owner_distribution` decimal(15,2) DEFAULT 0.00,
  `statement_date` date NOT NULL,
  `status` enum('draft','sent','acknowledged') DEFAULT 'draft',
  `notes` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `owner_statements`
--

INSERT INTO `owner_statements` (`id`, `statement_number`, `owner_id`, `property_id`, `statement_period_start`, `statement_period_end`, `total_rental_income`, `total_other_income`, `total_expenses`, `management_fee`, `net_income`, `owner_distribution`, `statement_date`, `status`, `notes`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'STMT2025001', 4, 1, '2025-01-01', '2025-01-31', 9000.00, 0.00, 430.00, 450.00, 8120.00, 8120.00, '2025-02-05', 'sent', NULL, 3, '2025-07-14 13:44:07', '2025-07-14 13:44:07'),
(2, 'STMT2025002', 4, 2, '2025-01-01', '2025-01-31', 2800.00, 0.00, 280.00, 140.00, 2380.00, 2380.00, '2025-02-05', 'sent', NULL, 3, '2025-07-14 13:44:07', '2025-07-14 13:44:07'),
(3, 'STMT2025003', 5, 3, '2025-01-01', '2025-01-31', 8000.00, 0.00, 0.00, 400.00, 7600.00, 7600.00, '2025-02-05', 'acknowledged', NULL, 3, '2025-07-14 13:44:07', '2025-07-14 13:44:07');

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `property_name` varchar(255) NOT NULL,
  `property_name_ar` varchar(500) DEFAULT NULL COMMENT 'Arabic property name',
  `address` varchar(500) NOT NULL,
  `address_ar` varchar(1000) DEFAULT NULL COMMENT 'Arabic address',
  `city` varchar(100) NOT NULL,
  `state` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT 'Saudi Arabia',
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `property_type` enum('residential','commercial','industrial','mixed') NOT NULL,
  `status` enum('available','rented','maintenance','sold','under_construction') DEFAULT 'available',
  `purchase_date` date DEFAULT NULL,
  `market_value` decimal(15,2) DEFAULT NULL,
  `total_units` int(11) DEFAULT 1,
  `year_built` year(4) DEFAULT NULL,
  `total_area` decimal(10,2) DEFAULT NULL COMMENT 'Total area in square meters',
  `description` text DEFAULT NULL,
  `description_ar` text DEFAULT NULL COMMENT 'Arabic description',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`id`, `owner_id`, `property_name`, `property_name_ar`, `address`, `address_ar`, `city`, `state`, `postal_code`, `country`, `latitude`, `longitude`, `property_type`, `status`, `purchase_date`, `market_value`, `total_units`, `year_built`, `total_area`, `description`, `description_ar`, `created_at`, `updated_at`) VALUES
(1, 4, 'Al-Nakheel Residential Complex', 'مجمع النخيل السكني', '123 Al-Nakheel District, Riyadh', 'حي النخيل 123، الرياض', 'Riyadh', 'Riyadh Province', NULL, 'Saudi Arabia', NULL, NULL, 'residential', 'available', NULL, 2500000.00, 12, '2020', 1500.50, NULL, NULL, '2025-07-14 13:30:13', '2025-07-14 13:30:13'),
(2, 4, 'Business Center Plaza', 'مجمع بلازا التجاري', '456 King Fahd Road, Riyadh', 'طريق الملك فهد 456، الرياض', 'Riyadh', 'Riyadh Province', NULL, 'Saudi Arabia', NULL, NULL, 'commercial', 'rented', NULL, 5000000.00, 8, '2018', 3000.75, NULL, NULL, '2025-07-14 13:30:13', '2025-07-14 13:30:13'),
(3, 5, 'Green Gardens Villas', 'فلل الحدائق الخضراء', '789 Al-Olaya Street, Riyadh', 'شارع العليا 789، الرياض', 'Riyadh', 'Riyadh Province', NULL, 'Saudi Arabia', NULL, NULL, 'residential', 'available', NULL, 1800000.00, 6, '2019', 2200.00, NULL, NULL, '2025-07-14 13:30:13', '2025-07-14 13:30:13'),
(4, 5, 'Industrial Zone Complex', 'مجمع المنطقة الصناعية', '321 Industrial Area, Riyadh', 'المنطقة الصناعية 321، الرياض', 'Riyadh', 'Riyadh Province', NULL, 'Saudi Arabia', NULL, NULL, 'industrial', 'maintenance', NULL, 3200000.00, 4, '2017', 5000.00, NULL, NULL, '2025-07-14 13:30:13', '2025-07-14 13:30:13');

-- --------------------------------------------------------

--
-- Table structure for table `property_amenities`
--

CREATE TABLE `property_amenities` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `amenity_type` varchar(100) NOT NULL,
  `amenity_name` varchar(150) NOT NULL,
  `amenity_name_ar` varchar(300) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `description_ar` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property_amenities`
--

INSERT INTO `property_amenities` (`id`, `property_id`, `amenity_type`, `amenity_name`, `amenity_name_ar`, `description`, `description_ar`, `is_active`) VALUES
(1, 1, 'security', 'Security Guard 24/7', 'حراسة أمنية 24/7', '24 hour security service', NULL, 1),
(2, 1, 'parking', 'Underground Parking', 'مواقف تحت الأرض', 'Covered parking spaces', NULL, 1),
(3, 1, 'recreation', 'Swimming Pool', 'مسبح', 'Community swimming pool', NULL, 1),
(4, 1, 'utilities', 'Backup Generator', 'مولد احتياطي', 'Emergency power backup', NULL, 1),
(5, 2, 'security', 'Access Control', 'نظام التحكم بالدخول', 'Electronic access control', NULL, 1),
(6, 2, 'parking', 'Valet Parking', 'مواقف بخدمة', 'Valet parking service', NULL, 1),
(7, 2, 'business', 'Conference Room', 'قاعة اجتماعات', 'Meeting and conference facilities', NULL, 1),
(8, 3, 'recreation', 'Private Garden', 'حديقة خاصة', 'Individual garden for each villa', NULL, 1),
(9, 3, 'utilities', 'Solar Panels', 'ألواح شمسية', 'Solar energy system', NULL, 1),
(10, 4, 'security', 'CCTV Surveillance', 'كاميرات مراقبة', 'Security camera system', NULL, 1),
(11, 4, 'logistics', 'Loading Dock', 'منصة تحميل', 'Truck loading and unloading area', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `property_categories`
--

CREATE TABLE `property_categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `category_name_ar` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `description_ar` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property_categories`
--

INSERT INTO `property_categories` (`id`, `category_name`, `category_name_ar`, `description`, `description_ar`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Luxury Residential', 'سكني فاخر', 'High-end residential properties with premium amenities', 'عقارات سكنية راقية مع وسائل راحة متميزة', 1, '2025-07-14 13:45:05', '2025-07-14 13:45:05'),
(2, 'Commercial Office', 'مكاتب تجارية', 'Office spaces for business and professional use', 'مساحات مكتبية للاستخدام التجاري والمهني', 1, '2025-07-14 13:45:05', '2025-07-14 13:45:05'),
(3, 'Retail Space', 'مساحات تجارية', 'Commercial spaces for retail and shopping purposes', 'مساحات تجارية للبيع بالتجزئة والتسوق', 1, '2025-07-14 13:45:05', '2025-07-14 13:45:05'),
(4, 'Industrial Warehouse', 'مستودعات صناعية', 'Large storage and industrial facilities', 'مرافق تخزين وصناعية كبيرة', 1, '2025-07-14 13:45:05', '2025-07-14 13:45:05'),
(5, 'Mixed Use', 'استخدام مختلط', 'Properties combining residential and commercial use', 'عقارات تجمع بين الاستخدام السكني والتجاري', 1, '2025-07-14 13:45:05', '2025-07-14 13:45:05');

-- --------------------------------------------------------

--
-- Table structure for table `property_images`
--

CREATE TABLE `property_images` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `image_path` varchar(255) NOT NULL,
  `image_type` enum('exterior','interior','amenity','floor_plan','document') DEFAULT 'interior',
  `title` varchar(200) DEFAULT NULL,
  `title_ar` varchar(400) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `sort_order` tinyint(4) DEFAULT 0,
  `file_size` int(11) DEFAULT NULL COMMENT 'File size in bytes',
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property_units`
--

CREATE TABLE `property_units` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `unit_number` varchar(50) NOT NULL,
  `floor_number` int(11) DEFAULT NULL,
  `bedrooms` tinyint(4) DEFAULT 0,
  `bathrooms` tinyint(4) DEFAULT 0,
  `square_feet` int(11) DEFAULT NULL,
  `square_meters` decimal(8,2) DEFAULT NULL,
  `rent_amount` decimal(10,2) DEFAULT NULL,
  `security_deposit` decimal(10,2) DEFAULT NULL,
  `status` enum('vacant','occupied','maintenance','reserved') DEFAULT 'vacant',
  `unit_type` enum('studio','apartment','office','shop','warehouse','villa') NOT NULL,
  `furnishing_status` enum('furnished','semi_furnished','unfurnished') DEFAULT 'unfurnished',
  `available_from` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `description_ar` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property_units`
--

INSERT INTO `property_units` (`id`, `property_id`, `unit_number`, `floor_number`, `bedrooms`, `bathrooms`, `square_feet`, `square_meters`, `rent_amount`, `security_deposit`, `status`, `unit_type`, `furnishing_status`, `available_from`, `description`, `description_ar`, `created_at`, `updated_at`) VALUES
(1, 1, 'A101', 1, 2, 2, NULL, 85.50, 3500.00, 7000.00, 'vacant', 'apartment', 'unfurnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22'),
(2, 1, 'A102', 1, 3, 2, NULL, 120.00, 4500.00, 9000.00, 'occupied', 'apartment', 'furnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22'),
(3, 1, 'A201', 2, 2, 2, NULL, 85.50, 3500.00, 7000.00, 'vacant', 'apartment', 'unfurnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22'),
(4, 1, 'A202', 2, 3, 2, NULL, 120.00, 4500.00, 9000.00, 'maintenance', 'apartment', 'semi_furnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22'),
(5, 2, 'B101', 1, 0, 1, NULL, 45.00, 2800.00, 5600.00, 'occupied', 'office', 'unfurnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22'),
(6, 2, 'B102', 1, 0, 1, NULL, 65.00, 3200.00, 6400.00, 'vacant', 'office', 'furnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22'),
(7, 3, 'V01', 1, 4, 3, NULL, 250.00, 8000.00, 16000.00, 'occupied', 'villa', 'furnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22'),
(8, 3, 'V02', 1, 5, 4, NULL, 300.00, 10000.00, 20000.00, 'vacant', 'villa', 'unfurnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22'),
(9, 4, 'W01', 1, 0, 1, NULL, 500.00, 5000.00, 10000.00, 'maintenance', 'warehouse', 'unfurnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22'),
(10, 4, 'W02', 1, 0, 1, NULL, 750.00, 7000.00, 14000.00, 'vacant', 'warehouse', 'unfurnished', NULL, NULL, NULL, '2025-07-14 13:30:22', '2025-07-14 13:30:22');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_name` varchar(100) NOT NULL,
  `permission_value` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `role_id`, `permission_name`, `permission_value`, `created_at`) VALUES
(2, 2, 'manage_properties', 1, '2025-07-14 13:06:50'),
(3, 2, 'manage_tenants', 1, '2025-07-14 13:06:50'),
(4, 2, 'manage_leases', 1, '2025-07-14 13:06:50'),
(5, 2, 'view_financials', 1, '2025-07-14 13:06:50'),
(6, 3, 'manage_financials', 1, '2025-07-14 13:06:50'),
(7, 3, 'generate_reports', 1, '2025-07-14 13:06:50'),
(8, 4, 'view_properties', 1, '2025-07-14 13:06:50'),
(9, 4, 'view_financials', 1, '2025-07-14 13:06:50'),
(10, 5, 'view_lease', 1, '2025-07-14 13:06:50'),
(11, 5, 'submit_maintenance', 1, '2025-07-14 13:06:50'),
(12, 5, 'make_payments', 1, '2025-07-14 13:06:50'),
(13, 6, 'manage_maintenance', 1, '2025-07-14 13:06:50'),
(14, 1, 'manage_users', 1, '2025-07-16 08:15:26'),
(15, 1, 'manage_roles', 1, '2025-07-16 08:15:26'),
(16, 1, 'system_settings', 1, '2025-07-16 08:15:26'),
(17, 1, 'view_system_logs', 1, '2025-07-16 08:15:26'),
(18, 1, 'database_backup', 1, '2025-07-16 08:15:26'),
(19, 1, 'manage_properties', 1, '2025-07-16 08:15:26'),
(20, 1, 'view_properties', 1, '2025-07-16 08:15:26'),
(21, 1, 'manage_units', 1, '2025-07-16 08:15:26'),
(22, 1, 'property_reports', 1, '2025-07-16 08:15:26'),
(23, 1, 'manage_tenants', 1, '2025-07-16 08:15:26'),
(24, 1, 'view_tenants', 1, '2025-07-16 08:15:26'),
(25, 1, 'tenant_screening', 1, '2025-07-16 08:15:26'),
(26, 1, 'tenant_documents', 1, '2025-07-16 08:15:26'),
(27, 1, 'manage_leases', 1, '2025-07-16 08:15:26'),
(28, 1, 'view_leases', 1, '2025-07-16 08:15:26'),
(29, 1, 'lease_renewal', 1, '2025-07-16 08:15:26'),
(30, 1, 'lease_termination', 1, '2025-07-16 08:15:26'),
(31, 1, 'manage_payments', 1, '2025-07-16 08:15:26'),
(32, 1, 'view_payments', 1, '2025-07-16 08:15:26'),
(33, 1, 'manage_invoices', 1, '2025-07-16 08:15:26'),
(34, 1, 'manage_expenses', 1, '2025-07-16 08:15:26'),
(35, 1, 'financial_reports', 1, '2025-07-16 08:15:26'),
(36, 1, 'process_payments', 1, '2025-07-16 08:15:26'),
(37, 1, 'make_payments', 1, '2025-07-16 08:15:26'),
(38, 1, 'manage_maintenance', 1, '2025-07-16 08:15:26'),
(39, 1, 'view_maintenance', 1, '2025-07-16 08:15:26'),
(40, 1, 'submit_maintenance', 1, '2025-07-16 08:15:26'),
(41, 1, 'assign_maintenance', 1, '2025-07-16 08:15:26'),
(42, 1, 'complete_maintenance', 1, '2025-07-16 08:15:26'),
(43, 1, 'manage_vendors', 1, '2025-07-16 08:15:26'),
(44, 1, 'send_messages', 1, '2025-07-16 08:15:26'),
(45, 1, 'view_messages', 1, '2025-07-16 08:15:26'),
(46, 1, 'manage_announcements', 1, '2025-07-16 08:15:26'),
(47, 1, 'view_announcements', 1, '2025-07-16 08:15:26'),
(48, 1, 'edit_profile', 1, '2025-07-16 08:15:26'),
(49, 1, 'change_password', 1, '2025-07-16 08:15:26');

-- --------------------------------------------------------

--
-- Table structure for table `system_logs`
--

CREATE TABLE `system_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `old_values` text DEFAULT NULL COMMENT 'JSON of old values',
  `new_values` text DEFAULT NULL COMMENT 'JSON of new values',
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `severity` enum('info','warning','error','critical') DEFAULT 'info',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_logs`
--

INSERT INTO `system_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `severity`, `description`, `created_at`) VALUES
(44, 1, 'LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'info', 'LOGIN', '2025-07-16 08:13:30'),
(45, 1, 'UPDATE_ROLE_PERMISSIONS', 'role_permissions', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'info', 'UPDATE_ROLE_PERMISSIONS', '2025-07-16 08:15:26');

-- --------------------------------------------------------

--
-- Table structure for table `tenants`
--

CREATE TABLE `tenants` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `first_name_ar` varchar(200) DEFAULT NULL,
  `last_name_ar` varchar(200) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `phone_secondary` varchar(20) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `id_number` varchar(50) DEFAULT NULL,
  `id_type` enum('national_id','passport','residence_permit') DEFAULT 'national_id',
  `emergency_contact_name` varchar(200) DEFAULT NULL,
  `emergency_contact_phone` varchar(20) DEFAULT NULL,
  `emergency_contact_relation` varchar(100) DEFAULT NULL,
  `current_address` text DEFAULT NULL,
  `occupation` varchar(150) DEFAULT NULL,
  `employer_name` varchar(200) DEFAULT NULL,
  `monthly_income` decimal(10,2) DEFAULT NULL,
  `status` enum('active','inactive','blacklisted','applicant') DEFAULT 'applicant',
  `credit_score` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tenants`
--

INSERT INTO `tenants` (`id`, `first_name`, `last_name`, `first_name_ar`, `last_name_ar`, `email`, `phone`, `phone_secondary`, `date_of_birth`, `gender`, `nationality`, `id_number`, `id_type`, `emergency_contact_name`, `emergency_contact_phone`, `emergency_contact_relation`, `current_address`, `occupation`, `employer_name`, `monthly_income`, `status`, `credit_score`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'Ahmed', 'Al-Mahmoud', 'أحمد', 'المحمود', 'ahmed.mahmoud@email.com', '+966501234580', NULL, NULL, NULL, 'Saudi', '1234567890', 'national_id', NULL, NULL, NULL, NULL, 'Engineer', NULL, 15000.00, 'active', NULL, NULL, '2025-07-14 13:30:46', '2025-07-14 13:30:46'),
(2, 'Sarah', 'Johnson', 'سارة', 'جونسون', 'sarah.johnson@email.com', '+966501234581', NULL, NULL, NULL, 'American', 'P123456789', 'national_id', NULL, NULL, NULL, NULL, 'Teacher', NULL, 8000.00, 'active', NULL, NULL, '2025-07-14 13:30:46', '2025-07-14 13:30:46'),
(3, 'Mohammed', 'Al-Rashid', 'محمد', 'الراشد', 'mohammed.rashid@email.com', '+966501234582', NULL, NULL, NULL, 'Saudi', '2345678901', 'national_id', NULL, NULL, NULL, NULL, 'Business Owner', NULL, 25000.00, 'active', NULL, NULL, '2025-07-14 13:30:46', '2025-07-14 13:30:46'),
(4, 'Fatima', 'Al-Zahra', 'فاطمة', 'الزهراء', 'fatima.zahra@email.com', '+966501234583', NULL, NULL, NULL, 'Saudi', '3456789012', 'national_id', NULL, NULL, NULL, NULL, 'Doctor', NULL, 20000.00, 'applicant', NULL, NULL, '2025-07-14 13:30:46', '2025-07-14 13:30:46'),
(5, 'John', 'Smith', 'جون', 'سميث', 'john.smith@email.com', '+966501234584', NULL, NULL, NULL, 'British', 'P987654321', 'national_id', NULL, NULL, NULL, NULL, 'Consultant', NULL, 18000.00, 'active', NULL, NULL, '2025-07-14 13:30:46', '2025-07-14 13:30:46');

-- --------------------------------------------------------

--
-- Table structure for table `tenant_applications`
--

CREATE TABLE `tenant_applications` (
  `id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `application_date` date NOT NULL,
  `desired_move_in_date` date DEFAULT NULL,
  `lease_duration_months` tinyint(4) DEFAULT 12,
  `monthly_rent_budget` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','under_review','approved','rejected','cancelled') DEFAULT 'pending',
  `screening_results` text DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tenant_applications`
--

INSERT INTO `tenant_applications` (`id`, `tenant_id`, `property_id`, `unit_id`, `application_date`, `desired_move_in_date`, `lease_duration_months`, `monthly_rent_budget`, `status`, `screening_results`, `rejection_reason`, `approved_by`, `approved_at`, `notes`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 3, '2025-02-01', '2025-03-01', 12, 3500.00, 'approved', 'Credit score: 750, Income verified, References checked', NULL, 2, '2025-02-05 08:30:00', 'Excellent candidate, quick approval', '2025-07-14 13:42:52', '2025-07-14 13:42:52'),
(2, 5, 2, 6, '2025-01-20', '2025-02-15', 18, 3200.00, 'under_review', 'Pending income verification', NULL, NULL, NULL, 'Awaiting employment letter', '2025-07-14 13:42:52', '2025-07-14 13:42:52'),
(3, 4, 3, 8, '2025-01-15', '2025-02-01', 12, 10000.00, 'rejected', 'Income insufficient for rent amount', NULL, 2, '2025-01-18 12:20:00', 'Monthly income below 3x rent requirement', '2025-07-14 13:42:52', '2025-07-14 13:42:52');

-- --------------------------------------------------------

--
-- Table structure for table `tenant_documents`
--

CREATE TABLE `tenant_documents` (
  `id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `document_type` enum('id_copy','passport','visa','salary_certificate','bank_statement','employment_letter','other') NOT NULL,
  `document_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `verification_status` enum('pending','verified','rejected') DEFAULT 'pending',
  `verified_by` int(11) DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tenant_documents`
--

INSERT INTO `tenant_documents` (`id`, `tenant_id`, `document_type`, `document_name`, `file_path`, `file_size`, `mime_type`, `verification_status`, `verified_by`, `verified_at`, `expiry_date`, `notes`, `upload_date`) VALUES
(1, 1, 'id_copy', 'Ahmed_National_ID.pdf', 'uploads/documents/tenants/1/ahmed_id_copy.pdf', 2048576, 'application/pdf', 'verified', 2, '2025-01-02 07:15:00', '2030-05-15', NULL, '2025-07-14 13:43:03'),
(2, 1, 'salary_certificate', 'Ahmed_Salary_Certificate.pdf', 'uploads/documents/tenants/1/ahmed_salary.pdf', 1536000, 'application/pdf', 'verified', 2, '2025-01-02 07:20:00', '2025-12-31', NULL, '2025-07-14 13:43:03'),
(3, 2, 'passport', 'Sarah_Passport.pdf', 'uploads/documents/tenants/2/sarah_passport.pdf', 3072000, 'application/pdf', 'verified', 2, '2025-02-02 09:30:00', '2028-03-20', NULL, '2025-07-14 13:43:03'),
(4, 2, 'employment_letter', 'Sarah_Employment_Letter.pdf', 'uploads/documents/tenants/2/sarah_employment.pdf', 1024000, 'application/pdf', 'verified', 2, '2025-02-02 09:35:00', NULL, NULL, '2025-07-14 13:43:03'),
(5, 3, 'id_copy', 'Mohammed_National_ID.pdf', 'uploads/documents/tenants/3/mohammed_id.pdf', 2560000, 'application/pdf', 'verified', 2, '2025-01-16 06:45:00', '2029-08-10', NULL, '2025-07-14 13:43:03'),
(6, 4, 'id_copy', 'Fatima_National_ID.pdf', 'uploads/documents/tenants/4/fatima_id.pdf', 2048000, 'application/pdf', 'pending', NULL, NULL, '2031-12-05', NULL, '2025-07-14 13:43:03'),
(7, 5, 'passport', 'John_Passport.pdf', 'uploads/documents/tenants/5/john_passport.pdf', 2816000, 'application/pdf', 'verified', 2, '2025-01-21 11:15:00', '2026-11-18', NULL, '2025-07-14 13:43:03');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `transaction_number` varchar(100) NOT NULL,
  `property_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `lease_id` int(11) DEFAULT NULL,
  `transaction_type` enum('income','expense') NOT NULL,
  `category` varchar(100) NOT NULL,
  `subcategory` varchar(100) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `transaction_date` date NOT NULL,
  `payment_method` enum('cash','bank_transfer','check','online','credit_card') DEFAULT NULL,
  `reference_number` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `description_ar` text DEFAULT NULL,
  `vendor_payee` varchar(255) DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `tax_rate` decimal(5,2) DEFAULT 0.00,
  `receipt_path` varchar(255) DEFAULT NULL,
  `status` enum('pending','completed','cancelled') DEFAULT 'completed',
  `created_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `transaction_number`, `property_id`, `unit_id`, `lease_id`, `transaction_type`, `category`, `subcategory`, `amount`, `transaction_date`, `payment_method`, `reference_number`, `description`, `description_ar`, `vendor_payee`, `tax_amount`, `tax_rate`, `receipt_path`, `status`, `created_by`, `approved_by`, `created_at`, `updated_at`) VALUES
(1, 'TXN2025001', 1, NULL, NULL, 'income', 'Rent Payment', NULL, 4500.00, '2025-01-01', NULL, NULL, 'Monthly rent payment from Ahmed Al-Mahmoud', 'دفعة إيجار شهرية من أحمد المحمود', NULL, 0.00, 0.00, NULL, 'completed', 3, NULL, '2025-07-14 13:31:38', '2025-07-14 13:31:38'),
(2, 'TXN2025002', 2, NULL, NULL, 'income', 'Rent Payment', NULL, 2800.00, '2025-02-01', NULL, NULL, 'Monthly rent payment from Sarah Johnson', 'دفعة إيجار شهرية من سارة جونسون', NULL, 0.00, 0.00, NULL, 'completed', 3, NULL, '2025-07-14 13:31:38', '2025-07-14 13:31:38'),
(3, 'TXN2025003', 1, NULL, NULL, 'expense', 'Maintenance', NULL, 150.00, '2025-01-15', NULL, NULL, 'Plumbing repair - kitchen sink', 'إصلاح سباكة - حوض المطبخ', NULL, 0.00, 0.00, NULL, 'completed', 3, NULL, '2025-07-14 13:31:38', '2025-07-14 13:31:38'),
(4, 'TXN2025004', 2, NULL, NULL, 'expense', 'Utilities', NULL, 280.00, '2025-01-31', NULL, NULL, 'Electricity bill for February', 'فاتورة الكهرباء لشهر فبراير', NULL, 0.00, 0.00, NULL, 'completed', 3, NULL, '2025-07-14 13:31:38', '2025-07-14 13:31:38'),
(5, 'TXN2025005', 3, NULL, NULL, 'income', 'Rent Payment', NULL, 8000.00, '2025-01-15', NULL, NULL, 'Monthly rent payment from Mohammed Al-Rashid', 'دفعة إيجار شهرية من محمد الراشد', NULL, 0.00, 0.00, NULL, 'completed', 3, NULL, '2025-07-14 13:31:38', '2025-07-14 13:31:38');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` enum('active','inactive','suspended','pending') DEFAULT 'pending',
  `email_verified` tinyint(1) DEFAULT 0,
  `last_login` timestamp NULL DEFAULT NULL,
  `failed_login_attempts` tinyint(4) DEFAULT 0,
  `locked_until` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role_id`, `first_name`, `last_name`, `phone`, `status`, `email_verified`, `last_login`, `failed_login_attempts`, `locked_until`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@property.com', '$2y$10$nKolJBxZW0sHLaugKaJpcOW.0xg4Z2qSnUPxQrssFV3qHJJ6mOfXG', 1, 'أحمد', 'محمد', '+966501234567', 'active', 1, '2025-07-16 08:13:30', 0, NULL, '2025-07-14 13:29:52', '2025-07-16 08:13:30'),
(2, 'manager1', 'manager@property.com', '$2y$10$nKolJBxZW0sHLaugKaJpcOW.0xg4Z2qSnUPxQrssFV3qHJJ6mOfXG', 2, 'سارة', 'أحمد', '+966501234568', 'active', 1, NULL, 0, NULL, '2025-07-14 13:29:52', '2025-07-15 04:31:05'),
(3, 'accountant1', 'accountant@property.com', '$2y$10$nKolJBxZW0sHLaugKaJpcOW.0xg4Z2qSnUPxQrssFV3qHJJ6mOfXG', 3, 'محمد', 'علي', '+966501234569', 'active', 1, NULL, 0, NULL, '2025-07-14 13:29:52', '2025-07-15 04:31:07'),
(4, 'owner1', 'owner1@property.com', '$2y$10$nKolJBxZW0sHLaugKaJpcOW.0xg4Z2qSnUPxQrssFV3qHJJ6mOfXG', 4, 'عبدالله', 'السعد', '+966501234570', 'active', 1, NULL, 0, NULL, '2025-07-14 13:29:52', '2025-07-15 04:31:09'),
(5, 'owner2', 'owner2@property.com', '$2y$10$nKolJBxZW0sHLaugKaJpcOW.0xg4Z2qSnUPxQrssFV3qHJJ6mOfXG', 4, 'فاطمة', 'الأحمد', '+966501234571', 'active', 1, NULL, 0, NULL, '2025-07-14 13:29:52', '2025-07-15 04:31:11'),
(6, 'maintenance1', 'maintenance@property.com', '$2y$10$nKolJBxZW0sHLaugKaJpcOW.0xg4Z2qSnUPxQrssFV3qHJJ6mOfXG', 6, 'علي', 'الغامدي', '+966501234572', 'active', 1, NULL, 0, NULL, '2025-07-14 13:29:52', '2025-07-15 04:31:13');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `role_name_ar` varchar(100) NOT NULL COMMENT 'Arabic role name',
  `role_description` text DEFAULT NULL,
  `permissions` text DEFAULT NULL COMMENT 'JSON encoded permissions',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `role_name`, `role_name_ar`, `role_description`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'system_admin', 'مدير النظام', 'Full system administrator access', '1', '2025-07-14 13:06:50', '2025-07-14 13:46:28'),
(2, 'property_manager', 'مدير العقارات', 'Property portfolio management', '2', '2025-07-14 13:06:50', '2025-07-14 13:46:51'),
(3, 'accountant', 'المحاسب', 'Financial management and reporting', NULL, '2025-07-14 13:06:50', '2025-07-14 13:06:50'),
(4, 'property_owner', 'مالك العقار', 'Property owner access', NULL, '2025-07-14 13:06:50', '2025-07-14 13:06:50'),
(5, 'tenant', 'المستأجر', 'Tenant portal access', NULL, '2025-07-14 13:06:50', '2025-07-14 13:06:50'),
(6, 'maintenance_worker', 'عامل الصيانة', 'Maintenance operations', NULL, '2025-07-14 13:06:50', '2025-07-14 13:06:50');

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` int(11) NOT NULL,
  `vendor_name` varchar(255) NOT NULL,
  `vendor_name_ar` varchar(500) DEFAULT NULL,
  `contact_person` varchar(200) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `phone_secondary` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `address_ar` text DEFAULT NULL,
  `tax_number` varchar(100) DEFAULT NULL,
  `license_number` varchar(100) DEFAULT NULL,
  `specialties` text DEFAULT NULL,
  `specialties_ar` text DEFAULT NULL,
  `service_areas` text DEFAULT NULL COMMENT 'JSON array of service areas',
  `rating` decimal(2,1) DEFAULT 0.0,
  `total_jobs_completed` int(11) DEFAULT 0,
  `average_response_time_hours` int(11) DEFAULT 0,
  `hourly_rate` decimal(8,2) DEFAULT NULL,
  `payment_terms` varchar(100) DEFAULT NULL,
  `insurance_expiry` date DEFAULT NULL,
  `license_expiry` date DEFAULT NULL,
  `status` enum('active','inactive','blacklisted') DEFAULT 'active',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `vendor_name`, `vendor_name_ar`, `contact_person`, `email`, `phone`, `phone_secondary`, `address`, `address_ar`, `tax_number`, `license_number`, `specialties`, `specialties_ar`, `service_areas`, `rating`, `total_jobs_completed`, `average_response_time_hours`, `hourly_rate`, `payment_terms`, `insurance_expiry`, `license_expiry`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'Ahmad Plumbing Services', 'خدمات أحمد للسباكة', 'أحمد محمد', 'ahmad@plumbing.com', '+966501111111', NULL, '123 King Fahd Road, Riyadh', 'طريق الملك فهد 123، الرياض', NULL, NULL, 'Plumbing, Pipe Repair', 'سباكة، إصلاح الأنابيب', NULL, 4.5, 0, 0, NULL, NULL, NULL, NULL, 'active', NULL, '2025-07-14 13:30:04', '2025-07-14 13:30:04'),
(2, 'Electric Solutions Co', 'شركة الحلول الكهربائية', 'محمد الكهربائي', 'info@electric.com', '+966501111112', NULL, '456 Olaya Street, Riyadh', 'شارع العليا 456، الرياض', NULL, NULL, 'Electrical Work, Wiring', 'أعمال كهربائية، توصيلات', NULL, 4.2, 0, 0, NULL, NULL, NULL, NULL, 'active', NULL, '2025-07-14 13:30:04', '2025-07-14 13:30:04'),
(3, 'CleanPro Services', 'خدمات كلين برو', 'سارة التنظيف', 'contact@cleanpro.com', '+966501111113', NULL, '789 Prince Sultan Road', 'طريق الأمير سلطان 789', NULL, NULL, 'Cleaning, Maintenance', 'تنظيف، صيانة', NULL, 4.7, 0, 0, NULL, NULL, NULL, NULL, 'active', NULL, '2025-07-14 13:30:04', '2025-07-14 13:30:04'),
(4, 'Al-Noor Maintenance', 'صيانة النور', 'عبدالله النور', 'info@alnoor.com', '+966501111114', NULL, '321 King Abdul Aziz Road', 'طريق الملك عبدالعزيز 321', NULL, NULL, 'General Maintenance, HVAC', 'صيانة عامة، تكييف', NULL, 4.3, 0, 0, NULL, NULL, NULL, NULL, 'active', NULL, '2025-07-14 13:30:04', '2025-07-14 13:30:04');

-- --------------------------------------------------------

--
-- Table structure for table `work_orders`
--

CREATE TABLE `work_orders` (
  `id` int(11) NOT NULL,
  `work_order_number` varchar(100) NOT NULL,
  `request_id` int(11) NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `work_instructions` text DEFAULT NULL,
  `estimated_hours` decimal(5,2) DEFAULT NULL,
  `actual_hours` decimal(5,2) DEFAULT NULL,
  `estimated_cost` decimal(15,2) DEFAULT NULL,
  `actual_cost` decimal(15,2) DEFAULT NULL,
  `materials_cost` decimal(12,2) DEFAULT 0.00,
  `labor_cost` decimal(12,2) DEFAULT 0.00,
  `scheduled_date` date DEFAULT NULL,
  `scheduled_time` time DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `status` enum('pending','scheduled','in_progress','on_hold','completed','cancelled') DEFAULT 'pending',
  `completion_notes` text DEFAULT NULL,
  `quality_rating` tinyint(4) DEFAULT NULL COMMENT '1-5 rating',
  `warranty_period_days` int(11) DEFAULT 0,
  `warranty_expiry_date` date DEFAULT NULL,
  `requires_followup` tinyint(1) DEFAULT 0,
  `followup_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `completed_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `work_orders`
--

INSERT INTO `work_orders` (`id`, `work_order_number`, `request_id`, `assigned_to`, `vendor_id`, `title`, `description`, `work_instructions`, `estimated_hours`, `actual_hours`, `estimated_cost`, `actual_cost`, `materials_cost`, `labor_cost`, `scheduled_date`, `scheduled_time`, `start_date`, `completion_date`, `status`, `completion_notes`, `quality_rating`, `warranty_period_days`, `warranty_expiry_date`, `requires_followup`, `followup_date`, `created_by`, `approved_by`, `completed_by`, `created_at`, `updated_at`) VALUES
(1, 'WO2025001', 1, 6, 1, 'Fix Kitchen Sink Leak', 'Replace faucet gasket and check water pressure', NULL, NULL, NULL, 150.00, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL, 'scheduled', NULL, NULL, 0, NULL, 0, NULL, 2, NULL, NULL, '2025-07-14 13:31:29', '2025-07-14 13:31:29'),
(2, 'WO2025002', 2, 6, 2, 'Replace Office Ceiling Lights', 'Install new LED ceiling fixtures and check wiring', NULL, NULL, NULL, 300.00, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL, 'in_progress', NULL, NULL, 0, NULL, 0, NULL, 2, NULL, NULL, '2025-07-14 13:31:29', '2025-07-14 13:31:29'),
(3, 'WO2025003', 3, 6, 4, 'AC Maintenance and Repair', 'Clean filters, check refrigerant levels, repair cooling issue', NULL, NULL, NULL, 450.00, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL, 'completed', NULL, NULL, 0, NULL, 0, NULL, 2, NULL, NULL, '2025-07-14 13:31:29', '2025-07-14 13:31:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_target_audience` (`target_audience`),
  ADD KEY `idx_target_property` (`target_property_id`),
  ADD KEY `idx_announcement_status` (`status`),
  ADD KEY `idx_published_announcements` (`published_at`,`status`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `expense_number` (`expense_number`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_property_expenses` (`property_id`),
  ADD KEY `idx_expense_category` (`expense_category`),
  ADD KEY `idx_expense_date` (`expense_date`),
  ADD KEY `idx_expense_status` (`status`),
  ADD KEY `idx_vendor_expenses` (`vendor_id`);

--
-- Indexes for table `file_uploads`
--
ALTER TABLE `file_uploads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_entity_files` (`entity_type`,`entity_id`),
  ADD KEY `idx_file_category` (`file_category`),
  ADD KEY `idx_file_hash` (`file_hash`),
  ADD KEY `idx_uploaded_by` (`uploaded_by`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_number` (`invoice_number`),
  ADD UNIQUE KEY `unique_invoice_number` (`invoice_number`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_tenant_invoices` (`tenant_id`),
  ADD KEY `idx_lease_invoices` (`lease_id`),
  ADD KEY `idx_invoice_status` (`status`),
  ADD KEY `idx_due_date` (`due_date`),
  ADD KEY `idx_overdue_invoices` (`due_date`,`status`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_invoice_items` (`invoice_id`);

--
-- Indexes for table `lease_agreements`
--
ALTER TABLE `lease_agreements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lease_number` (`lease_number`),
  ADD UNIQUE KEY `unique_lease_number` (`lease_number`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_tenant_leases` (`tenant_id`),
  ADD KEY `idx_unit_leases` (`unit_id`),
  ADD KEY `idx_lease_status` (`status`),
  ADD KEY `idx_lease_dates` (`start_date`,`end_date`),
  ADD KEY `idx_expiring_leases` (`end_date`,`status`),
  ADD KEY `idx_active_leases` (`status`,`end_date`);

--
-- Indexes for table `lease_payments`
--
ALTER TABLE `lease_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `processed_by` (`processed_by`),
  ADD KEY `idx_lease_payments` (`lease_id`),
  ADD KEY `idx_payment_status` (`status`),
  ADD KEY `idx_due_date` (`due_date`),
  ADD KEY `idx_payment_date` (`payment_date`),
  ADD KEY `idx_overdue_payments` (`due_date`,`status`),
  ADD KEY `idx_lease_payment_tracking` (`lease_id`,`status`,`due_date`);

--
-- Indexes for table `lease_renewals`
--
ALTER TABLE `lease_renewals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `new_lease_id` (`new_lease_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_original_lease_renewals` (`original_lease_id`),
  ADD KEY `idx_renewal_status` (`status`),
  ADD KEY `idx_renewal_date` (`renewal_date`);

--
-- Indexes for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `request_number` (`request_number`),
  ADD UNIQUE KEY `unique_request_number` (`request_number`),
  ADD KEY `idx_tenant_requests` (`tenant_id`),
  ADD KEY `idx_unit_requests` (`unit_id`),
  ADD KEY `idx_property_requests` (`property_id`),
  ADD KEY `idx_request_status` (`status`),
  ADD KEY `idx_request_priority` (`priority`),
  ADD KEY `idx_assigned_requests` (`assigned_to`),
  ADD KEY `idx_vendor_requests` (`vendor_id`),
  ADD KEY `idx_open_requests` (`status`,`priority`,`created_at`),
  ADD KEY `idx_maintenance_workflow` (`status`,`priority`,`created_at`);

--
-- Indexes for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_property_schedules` (`property_id`),
  ADD KEY `idx_unit_schedules` (`unit_id`),
  ADD KEY `idx_maintenance_type` (`maintenance_type`),
  ADD KEY `idx_next_due_date` (`next_due_date`,`is_active`),
  ADD KEY `idx_vendor_schedules` (`preferred_vendor_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `lease_id` (`lease_id`),
  ADD KEY `maintenance_request_id` (`maintenance_request_id`),
  ADD KEY `parent_message_id` (`parent_message_id`),
  ADD KEY `idx_sender_messages` (`sender_id`),
  ADD KEY `idx_recipient_messages` (`recipient_id`),
  ADD KEY `idx_message_thread` (`thread_id`),
  ADD KEY `idx_unread_messages` (`recipient_id`,`read_at`),
  ADD KEY `idx_message_type` (`message_type`),
  ADD KEY `idx_sent_at` (`sent_at`),
  ADD KEY `idx_message_threads` (`thread_id`,`sent_at`),
  ADD KEY `idx_user_communications` (`recipient_id`,`read_at`,`sent_at`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_notifications` (`user_id`),
  ADD KEY `idx_notification_type` (`notification_type`),
  ADD KEY `idx_unread_notifications` (`user_id`,`is_read`),
  ADD KEY `idx_notification_category` (`category`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Indexes for table `owner_statements`
--
ALTER TABLE `owner_statements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `statement_number` (`statement_number`),
  ADD UNIQUE KEY `unique_statement_number` (`statement_number`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_owner_statements` (`owner_id`),
  ADD KEY `idx_property_statements` (`property_id`),
  ADD KEY `idx_statement_period` (`statement_period_start`,`statement_period_end`),
  ADD KEY `idx_statement_date` (`statement_date`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_owner_properties` (`owner_id`),
  ADD KEY `idx_property_status` (`status`),
  ADD KEY `idx_property_type` (`property_type`),
  ADD KEY `idx_location` (`city`,`state`),
  ADD KEY `idx_coordinates` (`latitude`,`longitude`),
  ADD KEY `idx_property_search` (`status`,`property_type`,`city`),
  ADD KEY `idx_owner_financials` (`owner_id`);

--
-- Indexes for table `property_amenities`
--
ALTER TABLE `property_amenities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_property_amenities` (`property_id`),
  ADD KEY `idx_amenity_type` (`amenity_type`);

--
-- Indexes for table `property_categories`
--
ALTER TABLE `property_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_category_name` (`category_name`);

--
-- Indexes for table `property_images`
--
ALTER TABLE `property_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_property_images` (`property_id`),
  ADD KEY `idx_unit_images` (`unit_id`),
  ADD KEY `idx_image_type` (`image_type`),
  ADD KEY `idx_primary_images` (`property_id`,`is_primary`);

--
-- Indexes for table `property_units`
--
ALTER TABLE `property_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_property_unit` (`property_id`,`unit_number`),
  ADD KEY `idx_property_units` (`property_id`),
  ADD KEY `idx_unit_status` (`status`),
  ADD KEY `idx_available_units` (`status`,`available_from`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_role_permission` (`role_id`,`permission_name`),
  ADD KEY `idx_role_permission` (`role_id`,`permission_name`);

--
-- Indexes for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_logs` (`user_id`),
  ADD KEY `idx_action_logs` (`action`),
  ADD KEY `idx_table_record` (`table_name`,`record_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_severity` (`severity`);

--
-- Indexes for table `tenants`
--
ALTER TABLE `tenants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `id_number` (`id_number`),
  ADD KEY `idx_tenant_email` (`email`),
  ADD KEY `idx_tenant_id_number` (`id_number`),
  ADD KEY `idx_tenant_status` (`status`),
  ADD KEY `idx_tenant_name` (`first_name`,`last_name`);

--
-- Indexes for table `tenant_applications`
--
ALTER TABLE `tenant_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `idx_tenant_applications` (`tenant_id`),
  ADD KEY `idx_property_applications` (`property_id`),
  ADD KEY `idx_unit_applications` (`unit_id`),
  ADD KEY `idx_application_status` (`status`),
  ADD KEY `idx_application_date` (`application_date`);

--
-- Indexes for table `tenant_documents`
--
ALTER TABLE `tenant_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verified_by` (`verified_by`),
  ADD KEY `idx_tenant_documents` (`tenant_id`),
  ADD KEY `idx_document_type` (`document_type`),
  ADD KEY `idx_verification_status` (`verification_status`),
  ADD KEY `idx_expiry_date` (`expiry_date`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_number` (`transaction_number`),
  ADD UNIQUE KEY `unique_transaction_number` (`transaction_number`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `lease_id` (`lease_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `idx_property_transactions` (`property_id`),
  ADD KEY `idx_transaction_type` (`transaction_type`),
  ADD KEY `idx_transaction_date` (`transaction_date`),
  ADD KEY `idx_transaction_category` (`category`,`subcategory`),
  ADD KEY `idx_financial_reporting` (`property_id`,`transaction_type`,`transaction_date`),
  ADD KEY `idx_financial_reports` (`property_id`,`transaction_type`,`transaction_date`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role_status` (`role_id`,`status`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_name` (`role_name`),
  ADD KEY `idx_role_name` (`role_name`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `idx_user_session` (`user_id`),
  ADD KEY `idx_session_token` (`session_token`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vendor_name` (`vendor_name`),
  ADD KEY `idx_vendor_status` (`status`),
  ADD KEY `idx_vendor_rating` (`rating`),
  ADD KEY `idx_vendor_email` (`email`);

--
-- Indexes for table `work_orders`
--
ALTER TABLE `work_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `work_order_number` (`work_order_number`),
  ADD UNIQUE KEY `unique_work_order_number` (`work_order_number`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `completed_by` (`completed_by`),
  ADD KEY `idx_request_work_orders` (`request_id`),
  ADD KEY `idx_assigned_work_orders` (`assigned_to`),
  ADD KEY `idx_vendor_work_orders` (`vendor_id`),
  ADD KEY `idx_work_order_status` (`status`),
  ADD KEY `idx_scheduled_work_orders` (`scheduled_date`,`status`),
  ADD KEY `idx_vendor_performance` (`vendor_id`,`status`,`completion_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `file_uploads`
--
ALTER TABLE `file_uploads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lease_agreements`
--
ALTER TABLE `lease_agreements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lease_payments`
--
ALTER TABLE `lease_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `lease_renewals`
--
ALTER TABLE `lease_renewals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `owner_statements`
--
ALTER TABLE `owner_statements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `property_amenities`
--
ALTER TABLE `property_amenities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `property_categories`
--
ALTER TABLE `property_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `property_images`
--
ALTER TABLE `property_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_units`
--
ALTER TABLE `property_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `system_logs`
--
ALTER TABLE `system_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `tenants`
--
ALTER TABLE `tenants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tenant_applications`
--
ALTER TABLE `tenant_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tenant_documents`
--
ALTER TABLE `tenant_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `work_orders`
--
ALTER TABLE `work_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`target_property_id`) REFERENCES `properties` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `announcements_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `property_units` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_ibfk_3` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_ibfk_5` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `file_uploads`
--
ALTER TABLE `file_uploads`
  ADD CONSTRAINT `file_uploads_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_ibfk_2` FOREIGN KEY (`lease_id`) REFERENCES `lease_agreements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `invoice_items_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lease_agreements`
--
ALTER TABLE `lease_agreements`
  ADD CONSTRAINT `lease_agreements_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `lease_agreements_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `property_units` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `lease_agreements_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `lease_payments`
--
ALTER TABLE `lease_payments`
  ADD CONSTRAINT `lease_payments_ibfk_1` FOREIGN KEY (`lease_id`) REFERENCES `lease_agreements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lease_payments_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `lease_renewals`
--
ALTER TABLE `lease_renewals`
  ADD CONSTRAINT `lease_renewals_ibfk_1` FOREIGN KEY (`original_lease_id`) REFERENCES `lease_agreements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lease_renewals_ibfk_2` FOREIGN KEY (`new_lease_id`) REFERENCES `lease_agreements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `lease_renewals_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  ADD CONSTRAINT `maintenance_requests_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `maintenance_requests_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `property_units` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `maintenance_requests_ibfk_3` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `maintenance_requests_ibfk_4` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `maintenance_requests_ibfk_5` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD CONSTRAINT `maintenance_schedules_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `maintenance_schedules_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `property_units` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `maintenance_schedules_ibfk_3` FOREIGN KEY (`preferred_vendor_id`) REFERENCES `vendors` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `maintenance_schedules_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_4` FOREIGN KEY (`unit_id`) REFERENCES `property_units` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_5` FOREIGN KEY (`lease_id`) REFERENCES `lease_agreements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_6` FOREIGN KEY (`maintenance_request_id`) REFERENCES `maintenance_requests` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_7` FOREIGN KEY (`parent_message_id`) REFERENCES `messages` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `owner_statements`
--
ALTER TABLE `owner_statements`
  ADD CONSTRAINT `owner_statements_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `owner_statements_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `owner_statements_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `properties`
--
ALTER TABLE `properties`
  ADD CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `property_amenities`
--
ALTER TABLE `property_amenities`
  ADD CONSTRAINT `property_amenities_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `property_images`
--
ALTER TABLE `property_images`
  ADD CONSTRAINT `property_images_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `property_images_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `property_units` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `property_units`
--
ALTER TABLE `property_units`
  ADD CONSTRAINT `property_units_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD CONSTRAINT `system_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `tenant_applications`
--
ALTER TABLE `tenant_applications`
  ADD CONSTRAINT `tenant_applications_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tenant_applications_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tenant_applications_ibfk_3` FOREIGN KEY (`unit_id`) REFERENCES `property_units` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tenant_applications_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `tenant_documents`
--
ALTER TABLE `tenant_documents`
  ADD CONSTRAINT `tenant_documents_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tenant_documents_ibfk_2` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `property_units` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`lease_id`) REFERENCES `lease_agreements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_5` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `work_orders`
--
ALTER TABLE `work_orders`
  ADD CONSTRAINT `work_orders_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `maintenance_requests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `work_orders_ibfk_2` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `work_orders_ibfk_3` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `work_orders_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `work_orders_ibfk_5` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `work_orders_ibfk_6` FOREIGN KEY (`completed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
