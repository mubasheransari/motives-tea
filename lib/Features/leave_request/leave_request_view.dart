import 'package:flutter/material.dart';

bool rememberMe = false;
bool isPasswordVisible = false;


class LeaveApplicationFormScreen extends StatefulWidget {
  const LeaveApplicationFormScreen({super.key});

  @override
  State<LeaveApplicationFormScreen> createState() =>
      _LeaveApplicationFormScreenState();
}

class _LeaveApplicationFormScreenState
    extends State<LeaveApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _leaveType = 'Sick Leave';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const Text(
                "Leave Request",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              _buildTextField("Reason of Leave", false, 3),

              const SizedBox(height: 16),

              if (_leaveType != 'Sick Leave')
                const Text(
                  "Select Date",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              if (_leaveType != 'Sick Leave') SizedBox(height: 5),

              if (_leaveType != 'Sick Leave') _buildDateField(context, true),
              if (_leaveType != 'Sick Leave') _buildDateField(context, false),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Leave Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: ['Sick Leave', 'Casual Leave', 'Annual Leave']
                          .map(
                            (type) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [
                                Radio<String>(
                                  value: type,
                                  groupValue: _leaveType,
                                  onChanged: (val) {
                                    setState(() => _leaveType = val);
                                  },
                                ),
                                Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    if (_leaveType == null)
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Please select a leave type',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Sumbit".toUpperCase(),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, bool isPassword, int maxlines) {
    return TextField(
      maxLines: maxlines,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() => isPasswordVisible = !isPasswordVisible);
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
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
