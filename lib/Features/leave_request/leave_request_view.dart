import 'package:flutter/material.dart';
import '../../widgets/customScaffoldWidget.dart';

class LeaveApplicationFormScreen extends StatefulWidget {
  const LeaveApplicationFormScreen({super.key});

  @override
  State<LeaveApplicationFormScreen> createState() =>
      _LeaveApplicationFormScreenState();
}

class _LeaveApplicationFormScreenState
    extends State<LeaveApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();
  final _reasonController = TextEditingController();

  String? _leaveType;
  DateTime? _startDate;
  DateTime? _endDate;

  final Color primaryBlue = const Color(0xFF5D6EFF);

  _selectDate(BuildContext context, bool isStart) async {
    final initialDate = isStart
        ? DateTime.now()
        : (_startDate != null
            ? _startDate!.add(const Duration(days: 1))
            : DateTime.now());

    final firstDate = isStart
        ? DateTime.now()
        : (_startDate != null
            ? _startDate!.add(const Duration(days: 1))
            : DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null &&
              (_endDate!.isBefore(picked) ||
                  _endDate!.isAtSameMomentAs(picked))) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_leaveType != 'Sick Leave') {
        if (_startDate == null || _endDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please select both start and end dates')),
          );
          return;
        } else if (_endDate!.isBefore(_startDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('End date cannot be before start date')),
          );
          return;
        } else if (_endDate!.isAtSameMomentAs(_startDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Start and End date cannot be the same')),
          );
          return;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Leave Application Submitted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: 'Leave Request',
      isDrawerRequired: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_nameController, 'Full Name'),
              _buildTextField(_emailController, 'Email'),
              _buildTextField(_departmentController, 'Department'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Leave Type"),
                value: _leaveType,
                items: ['Sick Leave', 'Casual Leave', 'Annual Leave']
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (val) => setState(() => _leaveType = val),
                validator: (val) =>
                    val == null ? 'Please select a leave type' : null,
              ),
              const SizedBox(height: 20),
              if (_leaveType != 'Sick Leave') _buildDateField(context, true),
              if (_leaveType != 'Sick Leave') _buildDateField(context, false),
              const SizedBox(height: 10),
              TextFormField(
                controller: _reasonController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Reason for Leave',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a reason' : null,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _submitForm,
                child: Container(
                  height: 50,
                  width: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryBlue,
                  ),
                  child: const Center(
                    child: Text(
                      'Submit Leave Application',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: label),
        validator: (value) => value!.isEmpty ? 'This field is required' : null,
      ),
    );
  }


  Widget _buildDateField(BuildContext context, bool isStart) {
    final date = isStart ? _startDate : _endDate;
    final label = isStart ? "Start Date" : "End Date";
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (!isStart && _startDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select Start Date first')),
            );
            return;
          }
          _selectDate(context, isStart);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          child: Text(
            date == null
                ? 'Select date'
                : date.toLocal().toString().split(' ')[0],
          ),
        ),
      ),
    );
  }
}
