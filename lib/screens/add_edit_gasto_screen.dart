import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/gasto.dart';

class AddEditGastoScreen extends StatefulWidget {
  final Gasto? gasto;

  const AddEditGastoScreen({this.gasto, super.key});

  @override
  State<AddEditGastoScreen> createState() => _AddEditGastoScreenState();
}

class _AddEditGastoScreenState extends State<AddEditGastoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descripcionController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _montoController = TextEditingController();
  DateTime? _fecha;

  @override
  void initState() {
    super.initState();
    if (widget.gasto != null) {
      _descripcionController.text = widget.gasto!.descripcion;
      _categoriaController.text = widget.gasto!.categoria;
      _montoController.text = widget.gasto!.monto.toString();
      _fecha = widget.gasto!.fecha;
    }
  }

  Future<void> _seleccionarFecha() async {
    final fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: _fecha ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (fechaSeleccionada != null) {
      setState(() => _fecha = fechaSeleccionada);
    }
  }

  void _guardarGasto() async {
    if (_formKey.currentState!.validate() && _fecha != null) {
      final gasto = Gasto(
        id: widget.gasto?.id,
        descripcion: _descripcionController.text,
        categoria: _categoriaController.text,
        monto: double.parse(_montoController.text),
        fecha: _fecha!,
      );

      if (widget.gasto == null) {
        await DBHelper.insertarGasto(gasto);
      } else {
        await DBHelper.actualizarGasto(gasto);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gasto == null ? 'Agregar Gasto' : 'Editar Gasto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoría'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _montoController,
                decoration: const InputDecoration(labelText: 'Monto'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty || double.tryParse(value) == null
                    ? 'Ingrese un número válido'
                    : null,
              ),
              ListTile(
                title: Text(_fecha == null
                    ? 'Seleccionar fecha'
                    : 'Fecha: ${DateFormat('dd/MM/yyyy').format(_fecha!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _seleccionarFecha,
              ),
              ElevatedButton(
                onPressed: _guardarGasto,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}