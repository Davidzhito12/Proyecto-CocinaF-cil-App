import '../models/recipe.dart';

const List<Recipe> allRecipes = [
  Recipe(
    title: 'Brócoli con carne desmechada en salsa de tomate',
    subtitle: 'Sopa Colombiana estilo familiar',
    description: 'Una receta deliciosa con brócoli, carne y salsa de tomate. Ideal para el almuerzo o cena.',
    category: 'Almuerzo',
    image: 'https://via.placeholder.com/640x360?text=Br%C3%B3coli+con+carne',
    ingredients: [
      '1 brócoli grande cocido y troceado',
      '500 g carne desmechada',
      '2 tomates maduros grandes',
      '1 diente de ajo grande',
      '1/4 taza de caldo',
      '1/3 taza de crema de leche',
      'Sal y pimienta al gusto',
      'Aceite de oliva'
    ],
    steps: [
      'Saltea el ajo picado en aceite hasta dorar.',
      'Añade la carne desmechada y cocina por 5 min.',
      'Incorpora los tomates picados y cocina 10 min.',
      'Agrega el brócoli y el caldo, deja hervir 8 min.',
      'Añade la crema de leche, sal y pimienta. Cocina 3 min más.',
      'Sirve caliente.'
    ],
  ),
  Recipe(
    title: 'Sopa de lentejas colombiana',
    subtitle: 'Sopa tradicional con verduras',
    description: 'Calienta tu día con esta sopa de lentejas, muy nutritiva y fácil de preparar.',
    category: 'Sopas',
    image: 'https://via.placeholder.com/640x360?text=Sopa+de+lentejas',
    ingredients: [
      '250 g lentejas',
      '1 zanahoria en cubos',
      '1 papa en cubos',
      '1/2 cebolla picada',
      '1 diente de ajo',
      '1 tomate picado',
      '1 rama de apio',
      'Sal y comino al gusto',
      'Agua'
    ],
    steps: [
      'Remoja las lentejas 1 hora.',
      'Sofríe cebolla, ajo y tomate.',
      'Agrega lentejas y agua suficiente.',
      'Añade zanahoria, papa y apio. Cocina 35-40 min.',
      'Sazona con sal, pimienta y comino.',
      'Sirve con arroz o pan.'
    ],
  ),
  Recipe(
    title: 'Avena de desayuno saludable',
    subtitle: 'Desayuno ligero nutritivo',
    description: 'Una preparación rápida con avena, frutas y miel para empezar el día con energía.',
    category: 'Desayuno',
    image: 'https://via.placeholder.com/640x360?text=Avena+saludable',
    ingredients: [
      '1 taza de avena',
      '2 tazas de leche (o bebida vegetal)',
      '1 cucharada de miel',
      '1/2 banana en ruedas',
      'Frutos rojos al gusto',
      'Canela al gusto'
    ],
    steps: [
      'Hierve la leche y agrega la avena.',
      'Cocina a fuego bajo 8-10 min hasta espesar.',
      'Añade miel y canela.',
      'Sirve con banana y frutos rojos.',
      'Decora con semillas si deseas.'
    ],
  ),
  Recipe(
    title: 'Galletas de avena con chocolate',
    subtitle: 'Postre casero fácil',
    description: 'Galletas crujientes por fuera y suaves por dentro con hojuelas de avena y chocolate.',
    category: 'Galletas',
    image: 'https://via.placeholder.com/640x360?text=Galletas+de+avena',
    ingredients: [
      '1 taza de avena',
      '1/2 taza de harina',
      '1/2 taza de azúcar morena',
      '1 huevo',
      '1/4 taza de mantequilla',
      '1/4 taza de chips de chocolate',
      '1/2 cucharadita de polvo de hornear',
      '1 pizca de sal'
    ],
    steps: [
      'Mezcla ingredientes secos en un bol.',
      'Agrega huevo y mantequilla derretida, mezcla bien.',
      'Incorpora chips de chocolate.',
      'Forma bolitas y aplánalas sobre placa enmantecada.',
      'Hornea 12-15 min a 180°C.',
      'Enfría antes de servir.'
    ],
  ),
  Recipe(
    title: 'Arroz con pollo colombiano',
    subtitle: 'Almuerzo completo para compartir',
    description: 'Clásico plato con arroz, pollo y verduras sazonado al estilo colombiano.',
    category: 'Almuerzo',
    image: 'https://via.placeholder.com/640x360?text=Arroz+con+pollo',
    ingredients: [
      '2 tazas de arroz',
      '500 g de pollo',
      '1/2 cebolla',
      '1/2 pimiento rojo',
      '1 tomate',
      '2 cucharadas de salsa de tomate',
      '1 taza de arvejas',
      'Caldo de pollo',
      'Sal y pimienta'
    ],
    steps: [
      'Dora el pollo y reserva.',
      'Sofríe cebolla, pimiento y tomate.',
      'Agrega arroz y tuesta 2 min.',
      'Vierte caldo y salsa de tomate.',
      'Incorpora el pollo y las arvejas.',
      'Cocina tapado 18-20 min hasta absorber.',
      'Esponja con tenedor y sirve.'
    ],
  ),
  Recipe(
    title: 'Sopa de pollo con fideos',
    subtitle: 'Sopa rápida de comfort food',
    description: 'Sopa ligera con trozos de pollo, verduras y fideos para reconfortar.',
    category: 'Sopas',
    image: 'https://via.placeholder.com/640x360?text=Sopa+de+pollo',
    ingredients: [
      '1 pechuga de pollo',
      '1 zanahoria',
      '1 papa mediana',
      '1/2 cebolla',
      '1/2 taza de fideos',
      '1 litro de caldo',
      'Sal, pimienta y cilantro'
    ],
    steps: [
      'Hierve el pollo en el caldo 15 min.',
      'Retira y desmecha el pollo.',
      'Agrega verduras y cocina 10 min más.',
      'Añade los fideos y cuece 8 min.',
      'Regresa el pollo al caldo y sazona.',
      'Sirve con cilantro fresco.'
    ],
  ),
];
