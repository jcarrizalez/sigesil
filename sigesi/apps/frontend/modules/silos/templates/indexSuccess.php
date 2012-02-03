<h1>Si siloss List</h1>

<table>
  <thead>
    <tr>
      <th>Id</th>
      <th>Id centro acopio</th>
      <th>Nombre</th>
      <th>Ubicacion</th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($si_siloss as $si_silos): ?>
    <tr>
      <td><a href="<?php echo url_for('silos/edit?id='.$si_silos->getId()) ?>"><?php echo $si_silos->getId() ?></a></td>
      <td><?php echo $si_silos->getIdCentroAcopio() ?></td>
      <td><?php echo $si_silos->getNombre() ?></td>
      <td><?php echo $si_silos->getUbicacion() ?></td>
    </tr>
    <?php endforeach; ?>
  </tbody>
</table>

  <a href="<?php echo url_for('silos/new') ?>">New</a>
